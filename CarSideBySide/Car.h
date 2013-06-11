//
//  Car.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CarModel, Specification;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * highlights;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * landscapeImage;
@property (nonatomic, retain) NSNumber * orderKey;
@property (nonatomic, retain) NSString * portraitImage;
@property (nonatomic, retain) NSNumber * priceList;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * retailPrice;
@property (nonatomic, retain) NSDate * validUntil;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *lines;
@property (nonatomic, retain) NSSet *specifications;
@property (nonatomic, retain) CarModel *carModel;
@end

@interface Car (CoreDataGeneratedAccessors)

- (void)addLinesObject:(CarModel *)value;
- (void)removeLinesObject:(CarModel *)value;
- (void)addLines:(NSSet *)values;
- (void)removeLines:(NSSet *)values;

- (void)addSpecificationsObject:(Specification *)value;
- (void)removeSpecificationsObject:(Specification *)value;
- (void)addSpecifications:(NSSet *)values;
- (void)removeSpecifications:(NSSet *)values;

@end
