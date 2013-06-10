//
//  Maker.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/10/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedCar, Serie;

@interface Maker : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *comparedCars;
@property (nonatomic, retain) NSSet *series;
@end

@interface Maker (CoreDataGeneratedAccessors)

- (void)addComparedCarsObject:(ComparedCar *)value;
- (void)removeComparedCarsObject:(ComparedCar *)value;
- (void)addComparedCars:(NSSet *)values;
- (void)removeComparedCars:(NSSet *)values;

- (void)addSeriesObject:(Serie *)value;
- (void)removeSeriesObject:(Serie *)value;
- (void)addSeries:(NSSet *)values;
- (void)removeSeries:(NSSet *)values;

@end
