//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/28/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Line;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *maker;
@property (nonatomic, retain) Line *lines;

@end
