//
//  Car.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Line, Specification;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * highlights;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * orderKey;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * imageUrl;

@property (nonatomic, retain) Line *line;
@property (nonatomic, retain) NSSet *specifications;
@end

@interface Car (CoreDataGeneratedAccessors)

- (void)addSpecificationsObject:(Specification *)value;
- (void)removeSpecificationsObject:(Specification *)value;
- (void)addSpecifications:(NSSet *)values;
- (void)removeSpecifications:(NSSet *)values;

- (NSString *)model;
- (NSString *)modelWithBrand;
- (Specification *)specificationBySpecificationTypeName:(NSString *)name;

@end
