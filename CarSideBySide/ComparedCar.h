//
//  ComparedCar.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand, Comparative;

@interface ComparedCar : NSManagedObject

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) NSSet *comparatives;
@end

@interface ComparedCar (CoreDataGeneratedAccessors)

- (void)addComparativesObject:(Comparative *)value;
- (void)removeComparativesObject:(Comparative *)value;
- (void)addComparatives:(NSSet *)values;
- (void)removeComparatives:(NSSet *)values;

@end
