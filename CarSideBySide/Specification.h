//
//  Specification.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Car, Comparative, Feature, SpecificationType;

@interface Specification : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * landscapeImage;
@property (nonatomic, retain) NSString * portraitImage;
@property (nonatomic, retain) Car *car;
@property (nonatomic, retain) NSSet *comparatives;
@property (nonatomic, retain) NSSet *features;
@property (nonatomic, retain) SpecificationType *specificationType;
@end

@interface Specification (CoreDataGeneratedAccessors)

- (void)addComparativesObject:(Comparative *)value;
- (void)removeComparativesObject:(Comparative *)value;
- (void)addComparatives:(NSSet *)values;
- (void)removeComparatives:(NSSet *)values;

- (void)addFeaturesObject:(Feature *)value;
- (void)removeFeaturesObject:(Feature *)value;
- (void)addFeatures:(NSSet *)values;
- (void)removeFeatures:(NSSet *)values;

@end
