//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/10/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Maker, Model;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Maker *maker;
@property (nonatomic, retain) NSSet *models;
@end

@interface Serie (CoreDataGeneratedAccessors)

- (void)addModelsObject:(Model *)value;
- (void)removeModelsObject:(Model *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
