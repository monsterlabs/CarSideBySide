//
//  AppDelegate.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/28/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "AppDelegate.h"
#import <YISplashScreen.h>
#import <YISplashScreen+Migration.h>
#import <YISplashScreenAnimation.h>
#import <CoreData/CoreData.h>

#import "Offer.h"
#import "Maker.h"
#import "Serie.h"
#import "Line.h"
#import "Car.h"

#define SHOWS_MIGRATION_ALERT 1
#define USES_PRESET_ANIMATION 0

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [YISplashScreen show];
    
#if SHOWS_MIGRATION_ALERT
    void (^migrationBlock)(void) = ^{
        [self loadInitialData];
    };
#else
    void (^migrationBlock)(void) = nil;
#endif
    
    [YISplashScreen waitForMigration:migrationBlock completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
            [YISplashScreen hideWithAnimation:[YISplashScreenAnimation cubeAnimation]];
        else
            [YISplashScreen hideWithAnimation:[YISplashScreenAnimation fadeOutAnimation]];
        
    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CarSideBySide" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CarSideBySide.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)loadInitialData
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
    NSFetchRequest *mainRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Maker" inManagedObjectContext:context];
    [mainRequest setEntity:entity];
    NSError *mainError = nil;
    
    NSUInteger count = [context countForFetchRequest:mainRequest error:&mainError];
    
    if (count <= 0){
        
        NSArray *offers = [ NSArray arrayWithObjects:
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 528i Sedan Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_1.jpg", @"image",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-12-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 628i Coupe Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_2.jpg", @"image",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-11-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 728i Convertible Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_3.jpg", @"image",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-10-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 328i Sedan Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_1.jpg", @"image",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-09-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 128i Gran Turismo Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_2.jpg", @"image",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-08-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 7s28i Active E Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_3.jpg", @"image",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-07-29", @"validUntil",
                            nil],
                           nil];
        
        for (NSDictionary *dict in offers) {
            Offer *offer = (Offer *)[NSEntityDescription insertNewObjectForEntityForName:@"Offer" inManagedObjectContext: context];
            [offer setTitle: [dict valueForKey:@"title"]];
            [offer setBody: [dict valueForKey:@"body"]];
            [offer setImage: [dict valueForKey:@"image"]];
            [offer setUrl: [dict valueForKey:@"url"]];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-mm-dd"];
            [offer setValidUntil: [dateFormatter dateFromString: [dict valueForKey:@"validUntil"]]];
        }
        
        Maker *maker = (Maker *)[NSEntityDescription insertNewObjectForEntityForName: @"Maker" inManagedObjectContext: context];
        [maker setName: @"BMW"];
        
//        /* Loading cars for serie 1 */
//        Serie *serie_1 = (Serie *)[NSEntityDescription insertNewObjectForEntityForName: @"Serie" inManagedObjectContext: context];
//        [serie_1 setName: @"Serie 1"];
//        [maker addSeriesObject:serie_1];
//        
//        NSArray *lines = [NSArray arrayWithObjects: @"3 puertas", @"5 puertas", @"Coupe", @"Convertible", @"Active E", nil];
//        NSArray *cars = [NSArray arrayWithObjects:
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"125i", @"modelName", @"2013", @"year", @"bmw_s1_3_puertas.jpg", @"image", @"bmw_s1_3_puertas_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"126i", @"modelName", @"2013", @"year", @"bmw_s1_5_puertas.jpg", @"image", @"bmw_s1_5_puertas_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"127i", @"modelName", @"2013", @"year", @"bmw_s1_coupe.jpg", @"image", @"bmw_s1_coupe_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"128i", @"modelName", @"2013", @"year", @"bmw_s1_convertible.jpg", @"image", @"bmw_s1_convertible_large.jpg", @"largeImage", nil],
//                         [NSDictionary dictionaryWithObjectsAndKeys: @"129i", @"modelName", @"2013", @"year", @"bmw_s1_active_e.jpg", @"image", @"bmw_s1_active_e_large.jpg", @"largeImage", nil],
//                         nil];
//        
//        for (NSString *lineName in lines) {
//            Line *line = (Line *)[NSEntityDescription insertNewObjectForEntityForName: @"Line" inManagedObjectContext: context];
//            [line setName:lineName];
//            for (NSDictionary *dict in cars) {
//                Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName: @"Car" inManagedObjectContext: context];
//                NSString *modelName = [NSString stringWithFormat:@"%@ %@ %@",  @"Serie 1", [dict valueForKey:@"modelName"], lineName];
//                [car setModelName:modelName];
//                [car setYear:[NSNumber numberWithInt:[[dict valueForKey:@"year"] intValue]]];
//                [car setImage:[dict valueForKey:@"image"]];
//                [car setLargeImage:[dict valueForKey:@"largeImage"]];
//                [line addCarsObject:car];
//            }
//            [serie_1 addLinesObject: line];
//        }
//        
        /* Loading cars for serie 3 */
        Serie *serie_3 = (Serie *)[NSEntityDescription insertNewObjectForEntityForName: @"Serie" inManagedObjectContext: context];
        [serie_3 setName: @"Serie 3"];
        [maker addSeriesObject:serie_3];
        NSArray *lines = [NSArray arrayWithObjects:@"Sedan", @"Sedan Active Hybrid", @"Touring", @"Gran Turismo", @"Coupe", @"Convertible", nil];
        NSArray *cars = [NSArray arrayWithObjects:
                [NSDictionary dictionaryWithObjectsAndKeys: @"323i", @"modelName", @"2013", @"year", @"bmw_s3_sedan.jpg", @"image", @"bmw_s3_sedan_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"324i", @"modelName", @"2013", @"year", @"bmw_s3_sedan_active_hybrid.jpg", @"image", @"bmw_s3_sedan_active_hybrid_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"325i", @"modelName", @"2013", @"year", @"bmw_s3_touring.jpg", @"image", @"bmw_s3_touring_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"326i", @"modelName", @"2013", @"year", @"bmw_s3_gran_turismo.jpg", @"image", @"bmw_s3_gran_turismo_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"327i", @"modelName", @"2013", @"year", @"bmw_s3_coupe.jpg", @"image", @"bmw_s3_coupe_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"328i", @"modelName", @"2013", @"year", @"bmw_s3_convertible.jpg", @"image", @"bmw_s3_convertible_large.jpg", @"largeImage", nil],
                nil];
        
        for (NSString *lineName in lines) {
            Line *line = (Line *)[NSEntityDescription insertNewObjectForEntityForName: @"Line" inManagedObjectContext: context];
            [line setName:lineName];
            for (NSDictionary *dict in cars) {
                Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName: @"Car" inManagedObjectContext: context];
                NSString *modelName = [NSString stringWithFormat:@"%@ %@ %@",  @"Serie 3", [dict valueForKey:@"modelName"], lineName];
                [car setModelName:modelName];
                [car setYear:[NSNumber numberWithInt:[[dict valueForKey:@"year"] intValue]]];
                [car setImage:[dict valueForKey:@"image"]];
                [car setLargeImage:[dict valueForKey:@"largeImage"]];
                [line addCarsObject:car];
            }
            [serie_3 addLinesObject: line];
        }
        
        /* Loading cars for serie 5 */
        Serie *serie_5 = (Serie *)[NSEntityDescription insertNewObjectForEntityForName: @"Serie" inManagedObjectContext: context];
        [serie_5 setName: @"Serie 5"];
        [maker addSeriesObject:serie_5];
        lines = [NSArray arrayWithObjects:@"Sedan", @"Gran turismo", nil];
        cars = [NSArray arrayWithObjects:
                [NSDictionary dictionaryWithObjectsAndKeys: @"582i", @"modelName", @"2013", @"year", @"bmw_s5_sedan.jpg", @"image", @"bmw_s5_sedan_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"583i", @"modelName", @"2013", @"year", @"bmw_s5_gran_turismo.jpg", @"image", @"bmw_s5_gran_turismo_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"584i", @"modelName", @"2013", @"year", @"bmw_s5_sedan.jpg", @"image", @"bmw_s5_sedan_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"585i", @"modelName", @"2013", @"year", @"bmw_s5_gran_turismo.jpg", @"image", @"bmw_s5_gran_turismo_large.jpg", @"largeImage", nil],
                [NSDictionary dictionaryWithObjectsAndKeys: @"586i", @"modelName", @"2013", @"year", @"bmw_s5_gran_turismo.jpg", @"image", @"bmw_s5_gran_turismo_large.jpg", @"largeImage", nil],
                nil];
        
        for (NSString *lineName in lines) {
            Line *line = (Line *)[NSEntityDescription insertNewObjectForEntityForName: @"Line" inManagedObjectContext: context];
            [line setName:lineName];
            for (NSDictionary *dict in cars) {
                Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName: @"Car" inManagedObjectContext: context];
                NSString *modelName = [NSString stringWithFormat:@"%@ %@ %@", @"Serie 5", [dict valueForKey:@"modelName"], lineName];
                [car setModelName:modelName];
                [car setYear:[NSNumber numberWithInt:[[dict valueForKey:@"year"] intValue]]];
                [car setImage:[dict valueForKey:@"image"]];
                [car setLargeImage:[dict valueForKey:@"largeImage"]];
                [line addCarsObject:car];
            }
            [serie_5 addLinesObject: line];
        }
        NSError *error = nil;
        if(![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
