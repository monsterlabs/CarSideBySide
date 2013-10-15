//
//  Serie.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Serie.h"
#import "Brand.h"
#import "Line.h"
#import "NSManagedObject+Util.h"

@implementation Serie

@dynamic enabled;
@dynamic name;
@dynamic brand;
@dynamic lines;
@dynamic id;

- (void)setSerieFromDictionary:(NSDictionary*)dict;
{
    self.name = [dict valueForKey:@"name"];
    self.enabled = [Serie boolFromString:[dict valueForKey:@"enabled"]];
}

+ (NSArray *)findAllEnabled {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *className = NSStringFromClass([self class]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request setSortDescriptors: [NSArray arrayWithObject:sortDescriptors]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enabled == 1"];
    [request setPredicate:predicate];

    NSError *error;
    NSFetchedResultsController *fetchResults = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:(id)[appDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:@"CarCatalogStream"];
    
    [fetchResults performSelectorOnMainThread:@selector(performFetch:) withObject:nil waitUntilDone:YES modes:@[ NSRunLoopCommonModes ]] ;
    
    NSArray *fetchResult = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    return fetchResult ;
}


@end
