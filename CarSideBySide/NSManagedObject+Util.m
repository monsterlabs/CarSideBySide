//
//  NSManagedObject+Util.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/12/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "NSManagedObject+Util.h"

@implementation NSManagedObject (NSManagedObject_Util)



+ (NSNumber *)boolFromString:(NSString *)string
{
    return [NSNumber numberWithBool: [string isEqualToString:@"true"]];
}

+ (NSDate *)dateFromString:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    NSDate *date = [dateFormatter dateFromString: dateString];
    return date;
}

@end
