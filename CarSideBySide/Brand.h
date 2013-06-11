//
//  Brand.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedCar, Serie;

@interface Brand : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *comparativeCars;
@property (nonatomic, retain) NSSet *series;
@end

@interface Brand (CoreDataGeneratedAccessors)

- (void)addComparativeCarsObject:(ComparedCar *)value;
- (void)removeComparativeCarsObject:(ComparedCar *)value;
- (void)addComparativeCars:(NSSet *)values;
- (void)removeComparativeCars:(NSSet *)values;

- (void)addSeriesObject:(Serie *)value;
- (void)removeSeriesObject:(Serie *)value;
- (void)addSeries:(NSSet *)values;
- (void)removeSeries:(NSSet *)values;

@end
