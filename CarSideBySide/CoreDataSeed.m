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
#import "CarModel.h"
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

- (void)loadInitialData
{
    NSLog(@"Database data loading in progress...");
    [self insertOffers];
    [self insertBrands];
    [self insertSeries];
    [self insertCarModels];
    [self insertCars];
    [self insertSpecTypes];
    [self insertCarSpecifications];
    [self insertSpecFeatures];
}

# pragma - Database population methods
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
- (void)insertCarModels
{
    if ([[CarModel findAll] count] == 0) {
        [self logMessageForModel:@"CarModel"];
        for (Serie *serie in [Serie findAll]) {
            
            int max = [self random_max:8];
            for(int i = 1; i <= max; i++)
            {
                CarModel *carModel = (CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext:[appDelegate managedObjectContext]];
                carModel.name = [MBFakerLorem words:[self random_max:3]];
                carModel.enabled = @YES;
                carModel.serie = serie;
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

        for (CarModel *model in [CarModel findAll]) {
            int max = [self random_max:5];
            for (int i = 1; i <= max; i++)
            {
                Car *car = (Car*)[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:[appDelegate managedObjectContext]];
                car.modelName = [MBFakerLorem words:[self random_max:2]];
                car.enabled = @YES;
                car.highlights = [MBFakerLorem paragraphs:[self random_max:4]];
                car.image = [carJPGs objectAtIndex:arc4random_uniform([carJPGs count])];
                car.year = [NSNumber numberWithInt:2013];
                car.carModel = model;
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
                
                int max = [self random_max:5];
                for (int i = 1; i <= max; i++) {
                    Feature *feature = (Feature *)[NSEntityDescription insertNewObjectForEntityForName:@"Feature" inManagedObjectContext:[appDelegate managedObjectContext]];
                    feature.name = [NSString stringWithFormat:@"Feature %@",
                                  [MBFakerLorem paragraphs:[self random_max:2]]];
                    feature.descr = [MBFakerLorem word];
                    feature.highlighted  = [NSNumber numberWithInt:arc4random_uniform(1)];
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
