//
//  Offer.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Offer.h"
#import "AppDelegate.h"
#import "NSManagedObject+Util.h"
@interface Offer () <NSFetchedResultsControllerDelegate> {
    NSFetchedResultsController *_fetchedResultsController;    
}
@end

@implementation Offer

@dynamic body;
@dynamic enabled;
@dynamic image;
@dynamic largeImage;
@dynamic title;
@dynamic url;
@dynamic validUntil;

- (void)setOfferFromDictionary:(NSDictionary*)dict
{
    self.title = [dict valueForKey:@"title"];
    self.body = [dict valueForKey:@"body"];
    self.image = [dict valueForKey:@"image"];
    self.largeImage = [dict valueForKey:@"largeImage"];
    self.url = [dict valueForKey:@"url"];
    self.enabled = [Offer boolFromString:[dict valueForKey:@"enabled"]];
    self.validUntil = [Offer dateFromString: [dict valueForKey:@"validUntil"]];
}

+ (NSArray *)findEnabledOrValidUntil {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *className = NSStringFromClass([self class]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enabled == 1 AND validUntil >= %@", [NSDate date]];
    [request setPredicate:predicate];
    NSSortDescriptor *sortDescriptors = [NSSortDescriptor sortDescriptorWithKey:@"validUntil" ascending:NO];
    [request setSortDescriptors: [NSArray arrayWithObject:sortDescriptors]];
    NSError *error;
    NSFetchedResultsController *fetchResults = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:(id)[appDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:@"CarCataloStream"];
    

    [fetchResults performSelectorOnMainThread:@selector(performFetch:) withObject:nil waitUntilDone:YES modes:@[ NSRunLoopCommonModes ]] ;

    NSArray *fetchResult = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];

    return fetchResult ;
}

+ (NSArray *)findTitleLike:(NSString*)title
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString *className = NSStringFromClass([self class]);
    NSEntityDescription *entity = [NSEntityDescription entityForName:className inManagedObjectContext:[appDelegate managedObjectContext]];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"enabled == 1 AND validUntil >= %@ AND title CONTAINS[cd] %@", [NSDate date], title];
    
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *fetchResults = [[[appDelegate managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    
    return fetchResults;
}

@end
