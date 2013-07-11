//
//  Car.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CarModel, Line, Specification;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * highlights;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * orderKey;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) CarModel *carModel;
@property (nonatomic, retain) NSSet *lines;
@property (nonatomic, retain) NSSet *specifications;
@end

@interface Car (CoreDataGeneratedAccessors)

- (void)addLinesObject:(Line *)value;
- (void)removeLinesObject:(Line *)value;
- (void)addLines:(NSSet *)values;
- (void)removeLines:(NSSet *)values;

- (void)addSpecificationsObject:(Specification *)value;
- (void)removeSpecificationsObject:(Specification *)value;
- (void)addSpecifications:(NSSet *)values;
- (void)removeSpecifications:(NSSet *)values;

- (NSString *)model;
- (Specification *)specificationBySpecificationTypeName:(NSString *)name;

@end
