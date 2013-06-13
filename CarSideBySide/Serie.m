//
//  Serie.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Serie.h"
#import "Brand.h"
#import "CarModel.h"
#import "NSManagedObject+Util.h"


@implementation Serie

@dynamic enabled;
@dynamic name;
@dynamic brand;
@dynamic carModels;

- (void)setSerieFromDictionary:(NSDictionary*)dict;
{
    self.name = [dict valueForKey:@"name"];
    self.enabled = [Serie boolFromString:[dict valueForKey:@"enabled"]];
}
@end
