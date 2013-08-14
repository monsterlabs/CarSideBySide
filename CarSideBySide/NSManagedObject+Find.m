//
//  NSManagedObject+Find.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "NSManagedObject+Find.h"
#import "AppDelegate.h"
#import <NSDate+Helper.h>
@implementation NSManagedObject (NSManagedObject_Find)

+ (NSArray *)findAll {

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *className = NSStringFromClass([self class]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    
    NSError *error;
    NSArray *fetchResults = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    if (error != nil)
        NSLog(@"Managed Object Context has the following error in the findAll Method: %@", error);
    return fetchResults;
}

+ (NSArray *)findAllEnabled {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *className = NSStringFromClass([self class]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enabled == 1"];
    [request setPredicate:predicate];

    NSError *error;
    NSArray *fetchResults = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    if (error != nil)
        NSLog(@"Managed Object Context has the following error in the findAllEnabled Method: %@", error);
    
    return fetchResults;
}


@end
