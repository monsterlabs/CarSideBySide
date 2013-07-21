//
//  OfferIncrementalStore.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/20/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarSideBySideIncrementalStore.h"
#import "CarCatalogAPIClient.h"

@implementation CarSideBySideIncrementalStore

+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"CarSideBySide" withExtension:@"xcdatamodeld"]];
}

- (id <AFIncrementalStoreHTTPClient>)HTTPClient {
    return [CarCatalogAPIClient sharedClient];
}

@end
