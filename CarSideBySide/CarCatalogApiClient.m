//
//  CarCatalogApiClient.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 8/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarCatalogApiClient.h"

static NSString * const kCarCatalogAPIBaseURLString = @"http://localhost:3000/api/v1";
static NSString * const kCarCatalogAPIToken;

@implementation CarCatalogApiClient

+ (id)sharedInstance {
    static CarCatalogApiClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[CarCatalogApiClient alloc] initWithBaseURL:
                            [NSURL URLWithString:kCarCatalogAPIBaseURLString]];
    });
    
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //custom settings
        [self setDefaultHeader:@"x-api-token" value:kCarCatalogAPIToken];
        
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}

@end
