//
//  CarModel.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarModel.h"
#import "Car.h"
#import "Serie.h"
#import "NSManagedObject+Util.h"


@implementation CarModel

@dynamic enabled;
@dynamic name;
@dynamic cars;
@dynamic serie;

- (void)setSerieFromDictionary:(NSDictionary*)dict;
{
    self.name = [dict valueForKey:@"name"];
    self.enabled = [CarModel boolFromString:[dict valueForKey:@"enabled"]];
}

@end
