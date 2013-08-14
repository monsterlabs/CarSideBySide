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
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Offer" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
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
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Brand" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
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
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Serie" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
        for (NSDictionary *dict in [arr valueForKey:@"series"])
        {
            Serie *serie = (Serie *)[NSEntityDescription insertNewObjectForEntityForName:@"Serie" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [serie setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"brand"] valueForKey:@"id"];
            Brand *brand = [Brand findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:[[appDelegate coreDataStack] managedObjectContext]
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
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
        for (NSDictionary *dict in [arr valueForKey:@"lines"])
        {
            Line *line = (Line *)[NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [line setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"serie"] valueForKey:@"id"];
            Serie *serie = [Serie findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:[[appDelegate coreDataStack] managedObjectContext]
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
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
        for (NSDictionary *dict in [arr valueForKey:@"cars"])
        {
            Car *car = (Car *)[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [car setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"line"] valueForKey:@"id"];
            Line *line = [Line findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:[[appDelegate coreDataStack] managedObjectContext]
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
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"SpecificationType" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
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
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ComparedCar" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
        for (NSDictionary *dict in [arr valueForKey:@"comparedcars"])
        {
            ComparedCar *comparedCar = (ComparedCar *)[NSEntityDescription insertNewObjectForEntityForName:@"ComparedCar" inManagedObjectContext:self.coreDataStack.managedObjectContext];
            [comparedCar setValuesForKeysWithDictionary:[[self attributesForRepresentation:dict ofEntity:entity] mutableCopy]];
            NSNumber *belongsToId = [[dict valueForKey:@"brand"] valueForKey:@"id"];
            Brand *brand = [Brand findFirstWithPredicate:[NSPredicate predicateWithFormat:@"id == %@", belongsToId]
                                               inContext:[[appDelegate coreDataStack] managedObjectContext]
                                                   error:&error];
            [comparedCar setBrand:brand];
            [self.coreDataStack saveOrFail:^(NSError* error) {
                blockFailedToSave(error);
            }];
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
                [comparedCars addObject:comparedCar];
            }
            
            for (Specification *spec in [car specifications]) {
                
                for (ComparedCar *comparedCar in comparedCars) {
                    Comparative *comparative = (Comparative *)[NSEntityDescription insertNewObjectForEntityForName:@"Comparative" inManagedObjectContext:[appDelegate managedObjectContext]];
                    comparative.comparedCar = comparedCar;
                    comparative.specification = spec;
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

- (void)logMessageForModel:(NSString *)modelName
{
    NSLog(@"Inserting and updating data into the %@ model...", modelName);
}

- (int)random_max:(int)max
{
    int min = 1;
    return (min + arc4random_uniform(max));
}

- (void)dealloc
{
    NSLog(@"The database migration has finished");
}

- (NSString *)pathForEntity:(NSEntityDescription *)entity {
    return [self.inflector pluralize:[entity.name lowercaseString]];
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
