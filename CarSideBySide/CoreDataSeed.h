//
//  CoreDataSeed.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MBFaker.h>
#import <DVCoreDataFinders.h>
#import <AFNetworking.h>
#import <TTTDateTransformers.h>
#import <TTTStringInflector.h>
#import <objc/objc.h>
#import <AFJSONRequestOperation.h>
#import "CoreDataStack.h"

@interface CoreDataSeed : NSObject


@property (readonly, nonatomic, strong) TTTStringInflector *inflector;
@property (readwrite, nonatomic, strong) CoreDataStack *coreDataStack;

- (id)init;
- (void)migrateOffersOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave;
- (void)migrateBrandsOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave;
- (void)migrateSeriesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave;
- (void)migrateLinesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave;
- (void)migrateCarsOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave;
- (void)migrateSpecificationTypesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave;
- (void)migrateComparedCarsOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave;

@end

