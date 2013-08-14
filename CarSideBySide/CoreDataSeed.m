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

- (void)insertBrands
{
    [self logMessageForModel:@"Brand"];
    [[CarCatalogApiClient sharedInstance] getPath:@"brands.json" parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, id response) {
                                              NSEntityDescription *entity = [NSEntityDescription entityForName:@"Brand" inManagedObjectContext:[[appDelegate coreDataStack] managedObjectContext]];
                                              
                                              for (NSDictionary *dict in [response valueForKey:@"brands"])
                                              {
                                                  NSMutableDictionary *mutableDict = [[self attributesForRepresentation:dict ofEntity:entity] mutableCopy];
                                                  Brand *brand = (Brand *)[NSEntityDescription insertNewObjectForEntityForName:@"Brand" inManagedObjectContext:self.coreDataStack.managedObjectContext];
                                                  [brand setValuesForKeysWithDictionary:mutableDict];
                                                  NSError *error = nil;
                                                  [self.coreDataStack saveOrFail:^(NSError* error) {
                                                      NSLog(@"There was an error %@", error);
                                                      NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
                                                  }];
                                              }
                                              
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"Error fetching brands!");
                                              NSLog(@"%@", error);
                                          }];
    
}

- (void)insertSeries
{
    
    NSError *error = nil;
    for (Offer *serie in [Offer findAllInContext:self.coreDataStack.managedObjectContext error:&error]) {
        NSLog(@"Serie %@", serie.title);
        NSLog(@"Error %@", error);
    }
    //    [self logMessageForModel:@"Serie"];
    //    [[CarCatalogApiClient sharedInstance] getPath:@"series.json" parameters:nil
    //                                          success:^(AFHTTPRequestOperation *operation, id response) {
    //                                              NSEntityDescription *entity = [NSEntityDescription entityForName:@"Serie" inManagedObjectContext:[appDelegate managedObjectContext]];
    //
    //                                              for (NSDictionary *dict in [response valueForKey:@"series"])
    //                                              {
    //                                                  NSMutableDictionary *mutableDict = [[self attributesForRepresentation:dict ofEntity:entity] mutableCopy];
    //                                                  Serie *serie = (Serie *)[NSEntityDescription insertNewObjectForEntityForName:@"Serie" inManagedObjectContext:[appDelegate managedObjectContext]];
    //                                                  [serie setValuesForKeysWithDictionary:mutableDict];
    //                                                  id brand_id = [[dict valueForKey:@"brand"] valueForKey:@"id"];
    //                                                  NSError *error = nil;
    //                                                  Brand *brand  = [Brand findFirstWhereProperty:@"id" equals:brand_id inContext:[appDelegate managedObjectContext] error:&error];
    //                                                  NSLog(@"Brand %@", brand);
    //
    //                                                  [self saveContext];
    //                                              }
    //                                          }
    //                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //                                              NSLog(@"Error fetching series!");
    //                                              NSLog(@"%@", error);
    //                                          }];
}

- (void)insertLines
{
    
    [self logMessageForModel:@"Line"];
    [[CarCatalogApiClient sharedInstance] getPath:@"lines.json" parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, id response) {
                                              NSEntityDescription *entity = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:[appDelegate managedObjectContext]];
                                              
                                              for (NSDictionary *dict in [response valueForKey:@"lines"])
                                              {
                                                  NSMutableDictionary *mutableDict = [[self attributesForRepresentation:dict ofEntity:entity] mutableCopy];
                                                  Line *line = (Line *)[NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:[appDelegate managedObjectContext]];
                                                  [line setValuesForKeysWithDictionary:mutableDict];
                                                  id offer_id = [[dict valueForKey:@"serie"] valueForKey:@"id"];
                                                  NSError *error = nil;
                                                  Serie *serie  = [Serie findFirstWhereProperty:@"id" equals:@(1) inContext:[appDelegate managedObjectContext] error:&error];
                                                  NSLog(@"Offer id %@", serie);
                                                  //                                                  JournalEntry findFirstWhereProperty:@"id" equals:@(8) inContext:self.managedObjectContext error:nil]
                                                  //                                                  NSDictionary *relationshipRepresentations  = [self representationsForRelationshipsFromRepresentation:dict ofEntity:entity];
                                                  //                                                  for (NSString *relationshipName in relationshipRepresentations) {
                                                  //                                                      NSRelationshipDescription *relationship = [[entity relationshipsByName] valueForKey:relationshipName];
                                                  //                                                      id relationshipRepresentation = [relationshipRepresentations objectForKey:relationshipName];
                                                  //
                                                  //                                                      NSEntityDescription *entity = [NSEntityDescription entityForName:[relationshipName capitalizedString] inManagedObjectContext:[appDelegate managedObjectContext]];
                                                  //
                                                  //                                                      NSLog(@"Relationship Name %@", [relationshipName capitalizedString]);
                                                  //
                                                  //                                                      NSLog(@"Relationship Representation %@", relationshipRepresentation);
                                                  ////                                                      [line insertOrUpdateObjectsFromRepresentations:relationshipRepresentation ofEntity:relationship.destinationEntity fromResponse:response withContext:context error:error completionBlock:^(NSArray *managedObjects, NSArray *backingObjects) {
                                                  //
                                                  //                                                  }

                                              }
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"Error fetching lines!");
                                              NSLog(@"%@", error);
                                          }];
}

- (void)insertCars
{
    
    [self logMessageForModel:@"Car"];
    [[CarCatalogApiClient sharedInstance] getPath:@"cars.json" parameters:nil
                                          success:^(AFHTTPRequestOperation *operation, id response) {
                                              NSEntityDescription *entity = [NSEntityDescription entityForName:@"Car" inManagedObjectContext:[appDelegate managedObjectContext]];
                                              
                                              for (NSDictionary *dict in [response valueForKey:@"cars"])
                                              {
                                                  NSMutableDictionary *mutableDict = [[self attributesForRepresentation:dict ofEntity:entity] mutableCopy];
                                                  Car *line = (Car *)[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:[appDelegate managedObjectContext]];
                                                  [line setValuesForKeysWithDictionary:mutableDict];

                                              }
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              NSLog(@"Error fetching cars!");
                                              NSLog(@"%@", error);
                                          }];
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

- (NSDictionary *)representationsForRelationshipsFromRepresentation:(NSDictionary *)representation
                                                           ofEntity:(NSEntityDescription *)entity
{
    NSMutableDictionary *mutableRelationshipRepresentations = [NSMutableDictionary dictionaryWithCapacity:[entity.relationshipsByName count]];
    [entity.relationshipsByName enumerateKeysAndObjectsUsingBlock:^(id name, id relationship, BOOL *stop) {
        id value = [representation valueForKey:name];
        if (value) {
            if ([relationship isToMany]) {
                NSArray *arrayOfRelationshipRepresentations = nil;
                if ([value isKindOfClass:[NSArray class]]) {
                    arrayOfRelationshipRepresentations = value;
                } else {
                    arrayOfRelationshipRepresentations = [NSArray arrayWithObject:value];
                }
                
                [mutableRelationshipRepresentations setValue:arrayOfRelationshipRepresentations forKey:name];
            } else {
                [mutableRelationshipRepresentations setValue:value forKey:name];
            }
        }
    }];
    
    return mutableRelationshipRepresentations;
}


@end
