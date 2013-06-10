//
//  Car.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/10/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CarModel, Line, Specification;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * landscapeImage;
@property (nonatomic, retain) NSString * highlights;
@property (nonatomic, retain) NSNumber * orderKey;
@property (nonatomic, retain) NSString * portraitImage;
@property (nonatomic, retain) NSNumber * priceList;
@property (nonatomic, retain) NSNumber * retailPrice;
@property (nonatomic, retain) NSString * subModelName;
@property (nonatomic, retain) NSNumber * valid;
@property (nonatomic, retain) NSDate * validUntil;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *lines;
@property (nonatomic, retain) CarModel *carModel;
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

@end
