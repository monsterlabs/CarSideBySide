//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand, Manufacturer;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *carModels;
@property (nonatomic, retain) Manufacturer *maker;
@end

@interface Serie (CoreDataGeneratedAccessors)

- (void)addCarModelsObject:(Brand *)value;
- (void)removeCarModelsObject:(Brand *)value;
- (void)addCarModels:(NSSet *)values;
- (void)removeCarModels:(NSSet *)values;

@end
