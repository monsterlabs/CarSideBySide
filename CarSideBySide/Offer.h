//
//  Offer.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Offer : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * largeImage;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSDate * validUntil;

@end
