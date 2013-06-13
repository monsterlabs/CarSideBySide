//
//  Car.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Car.h"
#import "CarModel.h"
#import "Line.h"
#import "Specification.h"
#import "NSManagedObject+Util.h"

@implementation Car

@dynamic enabled;
@dynamic highlights;
@dynamic image;
@dynamic landscapeImage;
@dynamic modelName;
@dynamic orderKey;
@dynamic portraitImage;
@dynamic priceList;
@dynamic retailPrice;
@dynamic year;
@dynamic summary;
@dynamic carModel;
@dynamic lines;
@dynamic specifications;

- (void)setCarFromDictionary:(NSDictionary*)dict
{
    self.modelName = [dict valueForKey:@"modelName"];
    self.summary = [dict valueForKey:@"summary"];
    self.year = [NSNumber numberWithInt:[[dict valueForKey:@"year"] intValue]];
    self.highlights = [dict valueForKey:@"highligths"];
    self.enabled = [Car boolFromString:[dict valueForKey:@"enabled"]];
    self.image = [dict valueForKey:@"image"];
    self.landscapeImage = [dict valueForKey:@"landscapeImage"];
    self.portraitImage = [dict valueForKey:@"portraitImage"];
}

@end
