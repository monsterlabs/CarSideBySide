//
//  Car.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Car.h"
#import "Line.h"
#import "Serie.h"
#import "Brand.h"
#import "Specification.h"
#import "SpecificationType.h"

@implementation Car

@dynamic enabled;
@dynamic highlights;
@dynamic image;
@dynamic modelName;
@dynamic orderKey;
@dynamic year;
@dynamic id;
@dynamic imageUrl;

@dynamic line;
@dynamic specifications;

- (NSString *)model {
    NSString *model = [NSString stringWithFormat:@"%@ %@", self.modelName, self.year];
    return model;
}

- (NSString *)modelWithBrand {
    NSString *model = [NSString stringWithFormat:@"%@ %@ %@", self.line.serie.brand.name, self.modelName, self.year];
    return model;
}

- (Specification *)specificationBySpecificationTypeName:(NSString *)name;
{
    Specification *spec = nil;
    for (Specification *specification in self.specifications)
    {
        if ([specification.specificationType.name isEqualToString:name]) {
            spec = specification;
        }
    }
    return spec;
}
@end
