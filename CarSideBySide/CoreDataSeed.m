//
//  CoreDataSeed.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CoreDataSeed.h"
#import "AppDelegate.h"
#import "NSManagedObject+Find.h"
#import "Offer.h"
#import "Brand.h"
#import "Serie.h"
#import "Line.h"
#import "Car.h"
#import "SpecificationType.h"
#import "Specification.h"
#import "Feature.h"
#import "ComparedCar.h"
#import "Comparative.h"
#import "ComparedFeature.h"
#import <MBFaker.h>
#import <DVCoreDataFinders.h>

@implementation CoreDataSeed
@synthesize managedObjectContext;

# pragma - Public methods

- (id)init
{
    NSLog(@"Initializing the database data loading...");
    [MBFaker setLanguage:@"en"];
    
    return self;
}

-(void)loadInitialData
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Database Migrating...", nil) message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    //UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 80, 30, 30)];
    UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [alert addSubview:indicator];
    [indicator startAnimating];
    
    [alert show];
    
    dispatch_queue_t queue = dispatch_queue_create("mx.com.monsterlabs.carsidebyside.MyQueue", NULL);
    dispatch_async(queue, ^{
        [self loadOffers];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadBrands];
            [self loadSpecificationTypes];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadSeries];
                [self loadComparedCars];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadLines];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self loadCars];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self loadSpecifications];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self loadComparatives];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self loadComparedFeatures];
                                });
                            });
                        });
                    });
                });
                
            });
            
            
        });
    });
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    
}

# pragma - Database population methods
- (void)loadOffers

{
    
    if ([[Offer findAll] count] == 0 ) {
        [self logMessageForModel:@"Offer"];
        [Offer findAll];
    }
}

-  (void)loadBrands
{
    [self logMessageForModel:@"Brand"];
    [Brand findAll];
}


- (void)loadSeries
{
    [self logMessageForModel:@"Serie"];
    [Serie findAll];
}

- (void)loadLines
{
    [self logMessageForModel:@"Line"];
    [Line findAll];
}


- (void)loadComparedCars
{
    [self logMessageForModel:@"ComparedCar"];
    [ComparedCar findAll];
}


- (void)loadCars
{
    [self logMessageForModel:@"Car"];
    [Car findAll];
    
}

- (void)loadSpecificationTypes
{
    [self logMessageForModel:@"SpecificationType"];
    [SpecificationType findAll];
}

- (void)loadSpecifications
{
    [self logMessageForModel:@"Specification"];
    [Specification findAll];
    
}

- (void)loadComparatives
{
    [self logMessageForModel:@"Comparatives"];
    [Comparative findAll];
}


- (void)loadComparedFeatures
{
    [self logMessageForModel:@"ComparedFeatures"];
    [ComparedFeature  findAll];
}


- (void)logMessageForModel:(NSString *)modelName
{
    NSLog(@"Inserting data into the %@ model(s)...", modelName);
}


- (void)dealloc
{
    NSLog(@"Finishing the database data loading...");
}


@end
