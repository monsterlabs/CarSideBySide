//
//  Specification.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/30/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Car, Feature, SpecificationType;

@interface Specification : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) Car *car;
@property (nonatomic, retain) NSSet *features;
@property (nonatomic, retain) SpecificationType *specificationType;
@end

@interface Specification (CoreDataGeneratedAccessors)

- (void)addFeaturesObject:(Feature *)value;
- (void)removeFeaturesObject:(Feature *)value;
- (void)addFeatures:(NSSet *)values;
- (void)removeFeatures:(NSSet *)values;

@end
