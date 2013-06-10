//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/10/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CarModel, Maker;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Maker *maker;
@property (nonatomic, retain) NSSet *carModels;
@end

@interface Serie (CoreDataGeneratedAccessors)

- (void)addCarModelsObject:(CarModel *)value;
- (void)removeCarModelsObject:(CarModel *)value;
- (void)addCarModels:(NSSet *)values;
- (void)removeCarModels:(NSSet *)values;

@end
