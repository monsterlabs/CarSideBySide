//
//  ComparedCar.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "ComparedCar.h"
#import "Brand.h"
#import "Comparative.h"


@implementation ComparedCar

@dynamic image;
@dynamic modelName;
@dynamic year;
@dynamic brand;
@dynamic comparatives;

- (NSString *)model
{
    NSString *model = [NSString stringWithFormat:@"%@ %@", self.modelName, self.year];
    return model;
}
@end

