//
//  Comparative.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/30/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedCar, Feature;

@interface Comparative : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) ComparedCar *comparedCar;
@property (nonatomic, retain) Feature *feature;

@end
