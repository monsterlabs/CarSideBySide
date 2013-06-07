//
//  Car.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/7/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Line, Model, Specification;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * largeImage;
@property (nonatomic, retain) NSString * subModelName;
@property (nonatomic, retain) NSNumber * orderKey;
@property (nonatomic, retain) NSNumber * priceList;
@property (nonatomic, retain) NSNumber * retailPrice;
@property (nonatomic, retain) NSNumber * valid;
@property (nonatomic, retain) NSDate * validUntil;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSString * modelDescr;
@property (nonatomic, retain) Model *model;
@property (nonatomic, retain) NSSet *specifications;
@property (nonatomic, retain) NSSet *lines;
@end

@interface Car (CoreDataGeneratedAccessors)

- (void)addSpecificationsObject:(Specification *)value;
- (void)removeSpecificationsObject:(Specification *)value;
- (void)addSpecifications:(NSSet *)values;
- (void)removeSpecifications:(NSSet *)values;

- (void)addLinesObject:(Line *)value;
- (void)removeLinesObject:(Line *)value;
- (void)addLines:(NSSet *)values;
- (void)removeLines:(NSSet *)values;

@end
