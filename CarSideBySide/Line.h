//
//  Line.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/7/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Car, Serie;

@interface Line : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *cars;
@property (nonatomic, retain) Serie *serie;
@end

@interface Line (CoreDataGeneratedAccessors)

- (void)addCarsObject:(Car *)value;
- (void)removeCarsObject:(Car *)value;
- (void)addCars:(NSSet *)values;
- (void)removeCars:(NSSet *)values;

@end
