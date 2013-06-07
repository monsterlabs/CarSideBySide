//
//  Comparative.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/7/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Comparative : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSManagedObject *comparedCar;
@property (nonatomic, retain) NSManagedObject *specification;

@end
