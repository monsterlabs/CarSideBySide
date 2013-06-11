//
//  Manufacturer.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedCar;

@interface Manufacturer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *comparedCars;
@end

@interface Manufacturer (CoreDataGeneratedAccessors)

- (void)addComparedCarsObject:(ComparedCar *)value;
- (void)removeComparedCarsObject:(ComparedCar *)value;
- (void)addComparedCars:(NSSet *)values;
- (void)removeComparedCars:(NSSet *)values;

@end
