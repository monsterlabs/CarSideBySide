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
#import "CarCatalogApiClient.h"
#import "Brand.h"
#import "NetworkReachability.h"

@implementation CoreDataSeed
@synthesize inflector, coreDataStack;

# pragma - Public methods

- (id)init
{
    NSLog(@"The database migration has started");
    [MBFaker setLanguage:@"en"];
    inflector = [TTTStringInflector defaultInflector];
    coreDataStack = [appDelegate coreDataStack];
    
    return self;
}

- (void)migrateOffersOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Offer"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"offers.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Offer *offer in [Offer findAll]) { [self.coreDataStack.managedObjectContext deleteObject:offer]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Offer" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"offers"])
        {
            NSMutableDictionary *mutableDict = [[self attributesForRepresentation:dict ofEntity:entity] mutableCopy];
            Offer *offer = (Offer *)[NSEntityDescription insertNewObjectForEntityForName:@"Offer" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [offer setValuesForKeysWithDictionary:mutableDict];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateBrandsOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Brand"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"brands.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Brand *record in [Brand findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Brand" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"brands"])
        {
            NSMutableDictionary *mutableDict = [[self attributesForRepresentation:dict ofEntity:entity] mutableCopy];
            Brand *brand = (Brand *)[NSEntityDescription insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [brand setValuesForKeysWithDictionary:mutableDict];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateSeriesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Serie"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"series.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Serie *record in [Serie findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Serie" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"series"])
        {
            Serie *serie = (Serie *)[NSEntityDescription insertNewObjectForEntityForName:@"Serie" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [serie setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"brand"] valueForKey:@"id"];
            Brand *brand = [Brand findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:self.coreDataStack.managedObjectContext
                                                   error:&error];
            [serie setBrand:brand];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateLinesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Line"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"lines.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Line *record in [Line findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"lines"])
        {
            Line *line = (Line *)[NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [line setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"serie"] valueForKey:@"id"];
            Serie *serie = [Serie findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:self.coreDataStack.managedObjectContext
                                                   error:&error];
            [line setSerie:serie];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateCarsOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Car"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"cars.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Car *record in [Car findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"cars"])
        {
            Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [car setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"line"] valueForKey:@"id"];
            Line *line = [Line findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:self.coreDataStack.managedObjectContext
                                                   error:&error];
            [car setLine:line];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateSpecificationTypesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"SpecificationTypes"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"specification_types.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (SpecificationType *record in [SpecificationType findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"SpecificationType" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"specificationtypes"])
        {
            NSMutableDictionary *mutableDict = [[self attributesForRepresentation:dict ofEntity:entity] mutableCopy];
            SpecificationType *specType = (SpecificationType *)[NSEntityDescription insertNewObjectForEntityForName:@"SpecificationType" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [specType setValuesForKeysWithDictionary:mutableDict];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateComparedCarsOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"ComparedCar"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"compared_cars.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (ComparedCar *record in [ComparedCar findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ComparedCar" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"comparedcars"])
        {
            ComparedCar *comparedCar = (ComparedCar *)[NSEntityDescription insertNewObjectForEntityForName:@"ComparedCar" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [comparedCar setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"brand"] valueForKey:@"id"];
            Brand *brand = [Brand findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:self.coreDataStack.managedObjectContext
                                                   error:&error];
            [comparedCar setBrand:brand];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateSpecificationsOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Specification"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"specifications.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Specification *record in [Specification findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Specification" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"specifications"])
        {
            Specification *spec = (Specification *)[NSEntityDescription insertNewObjectForEntityForName:@"Specification" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [spec setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            
            NSNumber *carId = [[dict valueForKey:@"car"] valueForKey:@"id"];
            Car *car = [Car findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", carId]
                                               inContext:self.coreDataStack.managedObjectContext
                                                   error:&error];
            [spec setCar:car];

            NSNumber *specTypeId = [[dict valueForKey:@"specificationType"] valueForKey:@"id"];
            SpecificationType *specType = [SpecificationType findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", specTypeId]
                                         inContext:self.coreDataStack.managedObjectContext
                                             error:&error];
            [spec setSpecificationType:specType];

            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateFeaturesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Feature"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"features.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Feature *record in [Feature findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feature" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"features"])
        {
            Feature *feature = (Feature *)[NSEntityDescription insertNewObjectForEntityForName:@"Feature" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [feature setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"specification"] valueForKey:@"id"];
            Specification *spec = [Specification findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:self.coreDataStack.managedObjectContext
                                                   error:&error];
            [feature setSpecification:spec];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateComparativesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"Comparative"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"comparatives.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (Comparative *record in [Comparative findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Comparative" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"comparatives"])
        {
            Comparative *comparative = (Comparative *)[NSEntityDescription insertNewObjectForEntityForName:@"Comparative" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [comparative setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            
            NSNumber *comparedCarId = [[dict valueForKey:@"comparedCar"] valueForKey:@"id"];
            ComparedCar *comparedCar = [ComparedCar findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", comparedCarId]
                                         inContext:self.coreDataStack.managedObjectContext
                                             error:&error];
            [comparative setComparedCar:comparedCar];
            
            NSNumber *specId = [[dict valueForKey:@"specification"] valueForKey:@"id"];
            Specification *spec = [Specification findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", specId]
                                                                          inContext:self.coreDataStack.managedObjectContext
                                                                              error:&error];
            [comparative setSpecification:spec];
            
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}

- (void)migrateComparedFeaturesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self logMessageForModel:@"ComparedFeature"];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"compared_features.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:[url path] parameters:nil];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error) {
        blockFailedToSave(error);
    } else {
        for (ComparedFeature *record in [ComparedFeature findAll]) { [self.coreDataStack.managedObjectContext deleteObject:record]; }
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ComparedFeature" inManagedObjectContext:self.coreDataStack.managedObjectContext];
        for (NSDictionary *dict in [arr valueForKey:@"comparedfeatures"])
        {
            ComparedFeature *comparedFeature = (ComparedFeature *)[NSEntityDescription insertNewObjectForEntityForName:@"ComparedFeature" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [comparedFeature setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            
            NSNumber *featureId = [[dict valueForKey:@"feature"] valueForKey:@"id"];
            Feature *feature = [Feature findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", featureId]
                                                                 inContext:self.coreDataStack.managedObjectContext
                                                                     error:&error];
            [comparedFeature setFeature:feature];
            
            NSNumber *comparativeId = [[dict valueForKey:@"comparative"] valueForKey:@"id"];
            Comparative *comparative = [Comparative findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", comparativeId]
                                                              inContext:self.coreDataStack.managedObjectContext
                                                                  error:&error];
            [comparedFeature setComparative:comparative];
            
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
        }
    }
}


- (void)migrateCarComparativesOrFail:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    [self migrateBrandsOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateSeriesOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateLinesOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateCarsOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateSpecificationTypesOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateComparedCarsOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateSpecificationsOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateFeaturesOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateComparativesOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
    
    [self migrateComparedFeaturesOrFail:^(NSError* error){
        if (error != nil)
            blockFailedToSave(error);
    }];
}

- (void)downloadCarImages:(void(^)(NSError* errorOrNil))blockFailedToSave
{
    for (Car *car in [Car findAll])
    {        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:car.image];
        if(![fileManager fileExistsAtPath:imagePath])
        {
            NetworkReachability *networkReachability = [appDelegate networkReachability];
            if ([networkReachability isReachable])
            {
                [UIApplication sharedApplication].networkActivityIndicatorVisible =  YES;
                [AFImageDownloader imageDownloaderWithURLString:car.imageUrl autoStart:YES completion:^(UIImage *decompressedImage) {
                    NSData *binaryImage = UIImageJPEGRepresentation(decompressedImage, 0.8);
                    [binaryImage writeToFile:imagePath atomically:YES];
                    [UIApplication sharedApplication].networkActivityIndicatorVisible =  NO;
                }];
            }
        }
    }
}

- (void)logMessageForModel:(NSString *)modelName
{
    NSLog(@"Inserting and updating data into the %@ model...", modelName);
}

- (void)dealloc
{
    NSLog(@"The database migration has finished");
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
{
    if ([representation isEqual:[NSNull null]]) {
        return nil;
    }
    
    NSMutableDictionary *mutableAttributes = [representation mutableCopy];
    @autoreleasepool {
        NSMutableSet *mutableKeys = [NSMutableSet setWithArray:[representation allKeys]];
        [mutableKeys minusSet:[NSSet setWithArray:[entity.attributesByName allKeys]]];
        [mutableAttributes removeObjectsForKeys:[mutableKeys allObjects]];
        
        NSSet *keysWithNestedValues = [mutableAttributes keysOfEntriesPassingTest:^BOOL(id key, id obj, BOOL *stop) {
            return [obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]];
        }];
        [mutableAttributes removeObjectsForKeys:[keysWithNestedValues allObjects]];
    }
    
    [entity.attributesByName enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([(NSAttributeDescription *)obj attributeType] == NSDateAttributeType) {
            id value = [mutableAttributes valueForKey:key];
            if (value && ![value isEqual:[NSNull null]] && [value isKindOfClass:[NSString class]]) {
                [mutableAttributes setValue:[[NSValueTransformer valueTransformerForName:TTTISO8601DateTransformerName] reverseTransformedValue:value] forKey:key];
            }
        }
    }];
    
    return mutableAttributes;
}


@end
