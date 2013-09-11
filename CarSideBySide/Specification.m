//
//  Specification.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Specification.h"
#import "Car.h"
#import "Comparative.h"
#import "Feature.h"
#import "SpecificationType.h"
#import "ComparedCar.h"
#import "ComparedFeature.h"

@implementation Specification

@dynamic descr;
@dynamic image;
@dynamic id;
@dynamic car;
@dynamic features;
@dynamic specificationType;
@dynamic comparatives;

- (NSString *)specificationTypeName
{
    return self.specificationType.name;
}

- (NSString *)carModelName
{
    return self.car.modelWithBrand;
}

- (NSArray *)featuresArray
{
    NSMutableArray *featureArray = [NSMutableArray array];
    NSSortDescriptor *sequenceSorter = [NSSortDescriptor sortDescriptorWithKey:@"sequence" ascending:YES];
    NSArray *features = [[self.features allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sequenceSorter]];
    for (Feature *feature in features) {
        NSDictionary *featureDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     feature.nameORAdditionalInfo, @"name",
                                     feature.descr, @"descr",
                                     feature.highlighted, @"highlighted",
                                     nil];
        [featureArray addObject:featureDict];
    }
    return [featureArray copy];
}

- (NSDictionary *)specificationDictionary
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [self specificationTypeName], @"specificationType",
                          [self carModelName], @"carModel",
                          [self featuresArray], @"features",
                          nil];
    return dict;
}

- (NSArray *)comparativeHeaders
{
    NSSortDescriptor *idSorter = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES];
    NSArray *comparatives = [[self.comparatives allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:idSorter]];
    NSMutableArray *headers = [NSMutableArray array];
    for (Comparative *comparative in comparatives) {
        [headers addObject:comparative.comparedCar.model];
    }
    return headers;
}

- (NSArray *)comparativeRows
{
    NSSortDescriptor *sequenceSorter = [NSSortDescriptor sortDescriptorWithKey:@"sequence" ascending:YES];
    NSArray *features = [[self.features allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sequenceSorter]];
    NSMutableArray *comparedFeatureArray = [NSMutableArray array];
    NSSortDescriptor *comparativeIdSorter = [NSSortDescriptor sortDescriptorWithKey:@"comparative.id" ascending:YES];
    for (Feature *feature in features) {
        NSArray *comparedFeatures = [[feature.comparedFeatures allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:comparativeIdSorter]];
        NSMutableArray *colArray = [NSMutableArray array];
        for (ComparedFeature *comparedFeature in comparedFeatures) {
            [colArray addObject:comparedFeature.descr];
        }
        NSDictionary *row = [NSDictionary dictionaryWithObjectsAndKeys:colArray, @"columns", feature.highlighted, @"highlighted", nil];
        [comparedFeatureArray addObject:row];
    }
    return [comparedFeatureArray copy];
}

- (NSDictionary *)comparativesDictionary
{
    NSDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                          [self comparativeHeaders], @"headers",
                          [self comparativeRows], @"rows",
                          nil];
    return dict;
}

@end
