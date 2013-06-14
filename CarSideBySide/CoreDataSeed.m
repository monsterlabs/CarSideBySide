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
#import <MBFaker.h>
@implementation CoreDataSeed
@synthesize managedObjectContext;

// Brand *brand = (Brand *)[NSEntityDescription insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:[appDelegate managedObjectContext]];
// Serie *serie = (Serie *)[NSEntityDescription insertNewObjectForEntityForName: @"Serie" inManagedObjectContext:[appDelegate managedObjectContext]];
// CarModel *carModel = (CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext:[appDelegate managedObjectContext]];
// Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:[appDelegate managedObjectContext]];

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
}

# pragma - Database population methods
- (void)insertOffers {
    if ([[Offer findAll] count] == 0 ) {
         for (int i = 1; i <= 6; i++) {
            Offer *offer = (Offer *)[NSEntityDescription insertNewObjectForEntityForName:@"Offer" inManagedObjectContext:[appDelegate managedObjectContext]];
            offer.title = [MBFakerLorem words:7];
            offer.body = [MBFakerLorem paragraphs:7];
            offer.image = [NSString stringWithFormat:@"bmw_offer_test_%i.jpg", i];
            offer.largeImage = [NSString stringWithFormat:@"bmw_offer_test_%i_large.jpg", i];
            offer.url = [MBFakerInternet url];
            offer.enabled = [NSNumber numberWithBool:YES];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-mm-dd"];
            NSDate *date = [dateFormatter dateFromString: [NSString stringWithFormat:@"2012-0%i-01", i]];
            offer.validUntil = date;
            [self saveContext];
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

- (void)dealloc
{
    NSLog(@"Finishing the database data loading...");
}


// /* Loading cars for serie 1 */
//        Serie *serie_1 = (Serie *)[NSEntityDescription insertNewObjectForEntityForName: @"Serie" inManagedObjectContext: context];
//        [serie_1 setName: @"Serie 1"];
//        [maker addSeriesObject:serie_1];
//
//        NSArray *models = [NSArray arrayWithObjects: @"3 puertas", @"5 puertas", @"Coupe", @"Convertible", @"Active E", nil];
//        NSArray *cars = [NSArray arrayWithObjects:
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"125i", @"subModelName", @"2013", @"year", @"bmw_s1_3_puertas.jpg", @"image", @"bmw_s1_3_puertas_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"126i", @"subModelName", @"2013", @"year", @"bmw_s1_5_puertas.jpg", @"image", @"bmw_s1_5_puertas_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"127i", @"subModelName", @"2013", @"year", @"bmw_s1_coupe.jpg", @"image", @"bmw_s1_coupe_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"128i", @"subModelName", @"2013", @"year", @"bmw_s1_convertible.jpg", @"image", @"bmw_s1_convertible_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"129i", @"subModelName", @"2013", @"year", @"bmw_s1_active_e.jpg", @"image", @"bmw_s1_active_e_large.jpg", @"largeImage", nil],
//                         nil];
//
//        for (NSString *modelName in models) {
//            Model *model = (Model *)[NSEntityDescription insertNewObjectForEntityForName: @"Model" inManagedObjectContext: context];
//            [model setName:modelName];
//            for (NSDictionary *dict in cars) {
//                Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName: @"Car" inManagedObjectContext: context];
//                NSString *subModelName = [NSString stringWithFormat:@"%@ %@ %@",  @"Serie 1", [dict valueForKey:@"subModelName"], modelName];
//                [car setSubModelName:subModelName];
//                [car setYear:[NSNumber numberWithInt:[[dict valueForKey:@"year"] intValue]]];
//                [car setImage:[dict valueForKey:@"image"]];
//                [car setLargeImage:[dict valueForKey:@"largeImage"]];
//                [model addCarsObject:car];
//            }
//            [serie_1 addModelsObject: model];
//        }
//
/* Loading cars for serie 3 */
//        Serie *serie_3 = (Serie *)[NSEntityDescription insertNewObjectForEntityForName: @"Serie" inManagedObjectContext: context];
//        [serie_3 setName: @"Serie 3"];
//        [maker addSeriesObject:serie_3];
//        NSArray *models = [NSArray arrayWithObjects:@"Sedan", @"Sedan Active Hybrid", @"Touring", @"Gran Turismo", @"Coupe", @"Convertible", nil];
//        NSArray *cars = [NSArray arrayWithObjects:
//                [NSDictionary dictionaryWithObjectsAndKeys: @"323i", @"subModelName", @"2013", @"year", @"bmw_s3_sedan.jpg", @"image", @"bmw_s3_sedan_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"324i", @"subModelName", @"2013", @"year", @"bmw_s3_sedan_active_hybrid.jpg", @"image", @"bmw_s3_sedan_active_hybrid_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"325i", @"subModelName", @"2013", @"year", @"bmw_s3_touring.jpg", @"image", @"bmw_s3_touring_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"326i", @"subModelName", @"2013", @"year", @"bmw_s3_gran_turismo.jpg", @"image", @"bmw_s3_gran_turismo_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"327i", @"subModelName", @"2013", @"year", @"bmw_s3_coupe.jpg", @"image", @"bmw_s3_coupe_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"328i", @"subModelName", @"2013", @"year", @"bmw_s3_convertible.jpg", @"image", @"bmw_s3_convertible_large.jpg", @"largeImage", nil],
//                nil];
//
//        for (NSString *modelName in models) {
//            Model *model = (Model *)[NSEntityDescription insertNewObjectForEntityForName: @"Model" inManagedObjectContext: context];
//            [model setName:modelName];
//            for (NSDictionary *dict in cars) {
//                Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName: @"Car" inManagedObjectContext: context];
//                NSString *subModelName = [NSString stringWithFormat:@"%@ %@ %@",  @"Serie 3", [dict valueForKey:@"subModelName"], modelName];
//                [car setSubModelName:subModelName];
//                [car setYear:[NSNumber numberWithInt:[[dict valueForKey:@"year"] intValue]]];
//                [car setImage:[dict valueForKey:@"image"]];
//                [car setLargeImage:[dict valueForKey:@"largeImage"]];
//                [model addCarsObject:car];
//            }
//            [serie_3 addModelsObject:model];
//        }
//
//        /* Loading cars for serie 5 */
//        Serie *serie_5 = (Serie *)[NSEntityDescription insertNewObjectForEntityForName: @"Serie" inManagedObjectContext: context];
//        [serie_5 setName: @"Serie 5"];
//        [maker addSeriesObject:serie_5];
//        models = [NSArray arrayWithObjects:@"Sedan", @"Gran turismo", nil];
//        cars = [NSArray arrayWithObjects:
//                [NSDictionary dictionaryWithObjectsAndKeys: @"582i", @"subModelName", @"2013", @"year", @"bmw_s5_sedan.jpg", @"image", @"bmw_s5_sedan_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"583i", @"subModelName", @"2013", @"year", @"bmw_s5_gran_turismo.jpg", @"image", @"bmw_s5_gran_turismo_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"584i", @"subModelName", @"2013", @"year", @"bmw_s5_sedan.jpg", @"image", @"bmw_s5_sedan_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"585i", @"subModelName", @"2013", @"year", @"bmw_s5_gran_turismo.jpg", @"image", @"bmw_s5_gran_turismo_large.jpg", @"largeImage", nil],
//                [NSDictionary dictionaryWithObjectsAndKeys: @"586i", @"subModelName", @"2013", @"year", @"bmw_s5_gran_turismo.jpg", @"image", @"bmw_s5_gran_turismo_large.jpg", @"largeImage", nil],
//                nil];
//
//        for (NSString *modelName in models) {
//            Model *model = (Model *)[NSEntityDescription insertNewObjectForEntityForName: @"Model" inManagedObjectContext: context];
//            [model setName:modelName];
//            for (NSDictionary *dict in cars) {
//                Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName: @"Car" inManagedObjectContext: context];
//                NSString *subModelName = [NSString stringWithFormat:@"%@ %@ %@", @"Serie 5", [dict valueForKey:@"subModelName"], modelName];
//                [car setSubModelName:subModelName];
//                [car setYear:[NSNumber numberWithInt:[[dict valueForKey:@"year"] intValue]]];
//                [car setImage:[dict valueForKey:@"image"]];
//                [car setLargeImage:[dict valueForKey:@"largeImage"]];
//                [model addCarsObject:car];
//            }
//            [serie_5 addModelsObject:model];
//        }
//        NSError *error = nil;
//        if(![context save:&error]) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }


//-(void)insertBrands {
//    if ([[Brand findAll] count] == 0) {
//        NSLog(@"Inserting data into the Brand model..");
//        NSArray *brands = [NSArray arrayWithObjects:@"BMW", @"Audi", @"Volvo", @"Mercedes Benz", nil];
//        for (NSString *brandName in brands ) {
//            Brand *brand = [CoreDataSeed brandFromString:brandName];
//            [self saveContext];
//        }
//    }
//}
@end
