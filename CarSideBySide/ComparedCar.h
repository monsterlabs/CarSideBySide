//
//  ComparedCar.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/7/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comparative, Maker;

@interface ComparedCar : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *comparatives;
@property (nonatomic, retain) Maker *maker;
@end

@interface ComparedCar (CoreDataGeneratedAccessors)

- (void)addComparativesObject:(Comparative *)value;
- (void)removeComparativesObject:(Comparative *)value;
- (void)addComparatives:(NSSet *)values;
- (void)removeComparatives:(NSSet *)values;

@end
