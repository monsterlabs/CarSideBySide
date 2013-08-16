//
//  Comparative.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedCar, Specification;

@interface Comparative : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) ComparedCar *comparedCar;
@property (nonatomic, retain) Specification *specification;
@property (nonatomic, retain) NSSet *comparedFeatures;
@end

@interface Comparative (CoreDataGeneratedAccessors)

- (void)addComparedFeaturesObject:(NSManagedObject *)value;
- (void)removeComparedFeaturesObject:(NSManagedObject *)value;
- (void)addComparedFeatures:(NSSet *)values;
- (void)removeComparedFeatures:(NSSet *)values;

@end
