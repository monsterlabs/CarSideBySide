//
//  Maker.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/28/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Serie;

@interface Maker : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Serie *series;

@end
