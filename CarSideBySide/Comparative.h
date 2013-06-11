//
//  Comparative.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedCar, Feature, Specification;

@interface Comparative : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * portraitImage;
@property (nonatomic, retain) NSString * landscapeImage;
@property (nonatomic, retain) ComparedCar *comparedCar;
@property (nonatomic, retain) NSSet *features;
@property (nonatomic, retain) Specification *specification;
@end

@interface Comparative (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(Feature *)value;
- (void)removeFeaturesObject:(Feature *)value;
- (void)addFeatures:(NSSet *)values;
- (void)removeFeatures:(NSSet *)values;

@end
