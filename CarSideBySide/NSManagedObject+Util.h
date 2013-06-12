//
//  NSManagedObject+Util.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/12/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (UNSManagedObjec_Util)

+ (NSNumber *)boolFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString*)dateString;

@end
