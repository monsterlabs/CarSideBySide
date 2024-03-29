//
//  Specification.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Car, Comparative, Feature, SpecificationType;

@interface Specification : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Car *car;
@property (nonatomic, retain) NSSet *features;
@property (nonatomic, retain) SpecificationType *specificationType;
@property (nonatomic, retain) NSSet *comparatives;
@end

@interface Specification (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(Feature *)value;
- (void)removeFeaturesObject:(Feature *)value;
- (void)addFeatures:(NSSet *)values;
- (void)removeFeatures:(NSSet *)values;

- (void)addComparativesObject:(Comparative *)value;
- (void)removeComparativesObject:(Comparative *)value;
- (void)addComparatives:(NSSet *)values;
- (void)removeComparatives:(NSSet *)values;

- (NSString *)specificationTypeName;
- (NSString *)carModelName;
- (NSArray *)featuresArray;
- (NSDictionary *)specificationDictionary;
- (NSArray *)comparativeHeaders;
- (NSArray *)comparativeRows;
- (NSDictionary *)comparativesDictionary;

@end
