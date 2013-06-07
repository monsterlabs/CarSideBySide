//
//  Comparative.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/7/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedCar, Specification;

@interface Comparative : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) ComparedCar *comparedCar;
@property (nonatomic, retain) Specification *specification;

@end
