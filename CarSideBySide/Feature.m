//
//  Feature.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Feature.h"
#import "ComparedFeature.h"
#import "Specification.h"
#import "SpecificationType.h"

@implementation Feature

@dynamic additionalInfo;
@dynamic descr;
@dynamic highlighted;
@dynamic name;
@dynamic id;
@dynamic specification;
@dynamic comparedFeatures;

- (NSString *) nameORAdditionalInfo
{
    return [self.specification.specificationType.name isEqualToString:@"Opcionales"] ? ([NSString stringWithFormat:@"%@ %@",self.name, (self.additionalInfo ? self.additionalInfo : @"")]) : self.name;
}

@end
