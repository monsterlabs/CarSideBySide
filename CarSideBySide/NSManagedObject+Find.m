//
//  NSManagedObject+Find.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "NSManagedObject+Find.h"
#import "AppDelegate.h"

@implementation NSManagedObject (NSManagedObject_Find)

+(NSArray *)findAll {

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *className = NSStringFromClass([self class]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *fetchResults = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    
    return fetchResults;
}

@end
