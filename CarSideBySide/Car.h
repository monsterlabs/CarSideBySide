//
//  Car.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/31/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Line;

@interface Car : NSManagedObject

@property (nonatomic, retain) NSNumber * hp;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * largeImage;
@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * orderKey;
@property (nonatomic, retain) NSNumber * priceList;
@property (nonatomic, retain) NSNumber * retailPrice;
@property (nonatomic, retain) NSNumber * valid;
@property (nonatomic, retain) NSDate * validUntil;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSString * modelHighlights;
@property (nonatomic, retain) Line *line;

@end
