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
    dispatch_queue_t queue = dispatch_queue_create("mx.com.monsterlabs.carsidebyside.MyQueue", NULL);
    dispatch_async(queue, ^{
        [self loadOffers];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadBrands];
            [self loadSpecificationTypes];
            [self loadComparedCars];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadSeries];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self loadLines];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self loadCars];                        
                    });
                });
                
            });
        });
    });

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
    if ([[Brand findAll] count] == 0 ) {
        [self logMessageForModel:@"Brand"];
        [Brand findAll];
    }
}


- (void)loadSeries
{
    if ([[Serie findAll] count] == 0 ){
        [self logMessageForModel:@"Serie"];
        [Serie findAll];
    }
}

- (void)loadLines
{
    if ([[Line findAll] count] == 0) {
        [self logMessageForModel:@"Line"];
        [Line findAll];
    }
}


- (void)loadComparedCars
{
    if ([[ComparedCar findAll] count] == 0) {
        [self logMessageForModel:@"ComparedCar"];
        [ComparedCar findAll];
   }
}


- (void)loadCars
{
    if ([[Car findAll] count] == 0) {
        [self logMessageForModel:@"Car"];
        [Car findAll];
    }
    
}

- (void)loadSpecificationTypes
{
    if ([[SpecificationType findAll] count] == 0 )
    {
        [self logMessageForModel:@"SpecificationType"];
        [SpecificationType findAll];
    }
}

- (void)loadSpecifications
{
    if ([[Specification findAll] count] == 0) {
        [self logMessageForModel:@"Car"];
        [Specification findAll];
    }
    
}

- (void)loadComparatives
{
    if ([[Comparative findAll] count] == 0) {
        [self logMessageForModel:@"ComparedCar"];
        [Comparative findAll];
    }
}

- (void)loadFeatures
{
    if ([[Feature findAll] count] == 0) {
        [self logMessageForModel:@"ComparedCar"];
        [Feature findAll];
    }
}

- (void)loadComparedFeatures
{
    if ([[ComparedFeature findAll] count] == 0) {
        [self logMessageForModel:@"ComparedCar"];
        [ComparedFeature  findAll];
    }
}

- (void)insertOffers
{
    if ([[Offer findAll] count] == 0 ) {
        [self logMessageForModel:@"Offer"];
        for (int i = 1; i <= 9; i++) {
            Offer *offer = (Offer *)[NSEntityDescription insertNewObjectForEntityForName:@"Offer" inManagedObjectContext:[appDelegate managedObjectContext]];
            offer.title = [MBFakerLorem words:[self random_max:7]];
            offer.body = [MBFakerLorem paragraphs:[self random_max:5]];
            offer.image = [NSString stringWithFormat:@"bmw_offer_test_%i.jpg", i];
            offer.largeImage = [NSString stringWithFormat:@"bmw_offer_test_%i_large.jpg", i];
            offer.url = [MBFakerInternet url];
            offer.enabled = @YES;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-mm-dd"];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *currentDate = [NSDate date];
            NSDateComponents *dateComps = [[NSDateComponents alloc] init];
            [dateComps setMonth: i];
            NSDate *newDate =[calendar dateByAddingComponents:dateComps toDate:currentDate options:0];
            offer.validUntil = newDate;
            [self saveContext];
        }
    }
}

- (void)insertBrands
{
    if ([[Brand findAll] count] == 0) {
        [self logMessageForModel:@"Brand"];
        NSArray *brands = [NSArray arrayWithObjects:@"BMW", @"Audi", @"Volvo", @"Mercedes Benz", nil];
        for (NSString *brandName in brands ) {
            Brand *brand = (Brand *)[NSEntityDescription insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:[appDelegate managedObjectContext]];
            [brand setName:brandName];
            [self saveContext];
        }
    }
}

- (void)insertSeries
{
    if ([[Serie findAll] count] == 0 ){
        [self logMessageForModel:@"Serie"];
        Brand *bmw = [Brand findFirstWhereProperty:@"name" equals:@"BMW" inContext:[appDelegate managedObjectContext] error:nil];
        NSArray *series = [NSArray arrayWithObjects:@"Serie 1", @"Serie 3", @"Serie 4", @"Serie 5", @"Serie 6", @"Serie 7", @"Serie X", @"Serie Z4", @"Serie M", nil];
        for (NSString *serieName in series) {
            Serie *serie = (Serie *)[NSEntityDescription insertNewObjectForEntityForName:@"Serie" inManagedObjectContext:[appDelegate managedObjectContext]];
            serie.name = serieName;
            serie.enabled = @YES;
            serie.brand = bmw;
            [self saveContext];
        }
    }
}

- (void)insertLines
{
    if ([[Line findAll] count] == 0) {
        [self logMessageForModel:@"Line"];
        for (Serie *serie in [Serie findAll]) {
            
            int max = [self random_max:8];
            for(int i = 1; i <= max; i++)
            {
                Line *line = (Line *)[NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:[appDelegate managedObjectContext]];
                line.name = [MBFakerLorem words:[self random_max:3]];
                line.enabled = @YES;
                line.serie = serie;
                [self saveContext];
            }
            
        }
    }
}

- (void)insertCars
{
    if ([[Car findAll] count] == 0)
    {
        [self logMessageForModel:@"Car"];
        NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
        NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self BEGINSWITH 'bmw_s'"];
        NSArray *carJPGs = [dirContents filteredArrayUsingPredicate:fltr];

        for (Line *line in [Line findAll]) {
            int max = [self random_max:5];
            for (int i = 1; i <= max; i++)
            {
                Car *car = (Car*)[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:[appDelegate managedObjectContext]];
                car.modelName = [MBFakerLorem words:[self random_max:2]];
                car.enabled = @YES;
                car.highlights = [MBFakerLorem paragraphs:[self random_max:4]];
                car.image = [carJPGs objectAtIndex:arc4random_uniform([carJPGs count])];
                car.year = [NSNumber numberWithInt:2013];
                car.line = line;
                [self saveContext];
            }
        }
        
    }
}

- (void)insertSpecTypes
{
    if([[SpecificationType findAll] count] == 0 )
    {
        [self logMessageForModel:@"SpecificationType"];
        NSArray *specificationTypes = [NSArray arrayWithObjects: @"Technical details", @"Equipment", @"Safety", @"Lines", @"Price", nil];
        for (NSString *specTypeName in specificationTypes) {
            SpecificationType *specType = (SpecificationType*)[NSEntityDescription insertNewObjectForEntityForName:@"SpecificationType" inManagedObjectContext:[appDelegate managedObjectContext]];
            specType.name = specTypeName;
            [self saveContext];
        }
        
    }
}

- (void)insertCarSpecifications
{
    if ([[Specification findAll] count] == 0)
    {
        [self logMessageForModel:@"Specification"];
        for (Car *car in [Car findAll]) {
            for (SpecificationType *specType in [SpecificationType findAll]) {
                Specification *spec = (Specification *)[NSEntityDescription insertNewObjectForEntityForName:@"Specification" inManagedObjectContext:[appDelegate managedObjectContext]];
                spec.specificationType = specType;
                spec.car = car;
                spec.image = @"bmw_s3_gran_turismo.jpg";
                spec.descr = [MBFakerLorem paragraphs:[self random_max:2]];
                [self saveContext];
            }
        }
    }
}

- (void)insertSpecFeatures
{
    if ([[Feature findAll] count] == 0 )
    {
        [self logMessageForModel:@"Feature, ComparedCar, Comparative and ComparedFeature" ];
        for (Car *car in [Car findAll]){
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name != 'BMW'"];
            NSError *error;
            NSArray *brands = [Brand findAllWithPredicate:predicate inContext:[appDelegate managedObjectContext] error:&error];
            int maxComparedCars = [self random_max:[brands count]];
            NSMutableArray *comparedCars = [NSMutableArray array];
            for (int i = 0; i < maxComparedCars; i++) {
                ComparedCar *comparedCar = (ComparedCar *)[NSEntityDescription insertNewObjectForEntityForName:@"ComparedCar" inManagedObjectContext:[appDelegate managedObjectContext]];
                comparedCar.modelName = [MBFakerLorem word];
                comparedCar.brand = [brands objectAtIndex:i];
                comparedCar.year = [NSNumber numberWithInt:2013];
                [self saveContext];
                [comparedCars addObject:comparedCar];
            }
            
            for (Specification *spec in [car specifications]) {
                
                for (ComparedCar *comparedCar in comparedCars) {
                    Comparative *comparative = (Comparative *)[NSEntityDescription insertNewObjectForEntityForName:@"Comparative" inManagedObjectContext:[appDelegate managedObjectContext]];
                    comparative.comparedCar = comparedCar;
                    comparative.specification = spec;
                    [self saveContext];
                }
                
                int max = [self random_max:10];
                for (int i = 1; i <= max; i++) {
                    Feature *feature = (Feature *)[NSEntityDescription insertNewObjectForEntityForName:@"Feature" inManagedObjectContext:[appDelegate managedObjectContext]];
                    feature.name = [NSString stringWithFormat:@"Feature %@",
                                  [MBFakerLorem words:[self random_max:2]]];
                    feature.descr = [MBFakerLorem word];
                    feature.highlighted  = [NSNumber numberWithInt:arc4random_uniform(1)];
                    if (i == max) {
                        feature.highlighted = @YES;
                    }
                    feature.specification = spec;
                    [self saveContext];
                    for (Comparative *comparative in spec.comparatives)
                    {
                        ComparedFeature *compFeature = (ComparedFeature *)[NSEntityDescription insertNewObjectForEntityForName:@"ComparedFeature" inManagedObjectContext:[appDelegate managedObjectContext]];
                        compFeature.descr = [MBFakerLorem word];
                        compFeature.feature = feature;
                        compFeature.comparative = comparative;
                    }                    
                }
            }
        }
    }
}

- (void)saveContext
{
    NSError *error;
    [[appDelegate managedObjectContext] save:&error];
    if (error != nil)
        NSLog(@"Managed Object Context has the following error: %@", error);
}

- (void)logMessageForModel:(NSString *)modelName
{
    NSLog(@"Inserting data into the %@ model(s)...", modelName);
}

- (int)random_max:(int)max
{
    int min = 1;
    return (min + arc4random_uniform(max));
}

- (void)dealloc
{
    NSLog(@"Finishing the database data loading...");
}


@end
