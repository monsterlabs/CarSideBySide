//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/7/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Maker, Model;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *models;
@property (nonatomic, retain) Maker *maker;
@end

@interface Serie (CoreDataGeneratedAccessors)

- (void)addModelsObject:(Model *)value;
- (void)removeModelsObject:(Model *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
