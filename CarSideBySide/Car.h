//
//  Car.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand, Line, Specification;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * highlights;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * landscapeImage;
@property (nonatomic, retain) NSNumber * orderKey;
@property (nonatomic, retain) NSString * portraitImage;
@property (nonatomic, retain) NSNumber * priceList;
@property (nonatomic, retain) NSNumber * retailPrice;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSDate * validUntil;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSSet *lines;
@property (nonatomic, retain) NSSet *specifications;
@property (nonatomic, retain) Brand *brand;
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
