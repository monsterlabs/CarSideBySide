//
//  Feature.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Feature.h"
#import "ComparedFeature.h"
#import "Specification.h"
#import "SpecificationType.h"

@implementation Feature

@dynamic additionalInfo;
@dynamic descr;
@dynamic highlighted;
@dynamic name;
@dynamic id;
@dynamic sequence;
@dynamic specification;
@dynamic comparedFeatures;

- (NSString *) nameORAdditionalInfo
{
    return [NSString stringWithFormat:@"%@\n%@", self.name, (self.additionalInfo ? self.additionalInfo : @"")];
}

@end
