//
//  CarCatalogApiClient.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 8/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarCatalogApiClient.h"
#import "AppDelegate.h"

#define cProtocol @"https"
#define cPort @"443"
#define cApiPath @"api/v1"
#define kApiToken @"hKfxHddtln1XPWw1bIwVefodA2p9MROequn/oEG"

@implementation CarCatalogApiClient

+ (id)sharedInstance {
    static CarCatalogApiClient *_sharedInstance;
    static dispatch_once_t onceToken;
    NSString *kCarCatalogAPIBaseURLString = [NSString stringWithFormat:@"%@://%@:%@/%@",cProtocol, cHost, cPort, cApiPath];
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CarCatalogApiClient alloc] initWithBaseURL:
                            [NSURL URLWithString:kCarCatalogAPIBaseURLString]];
    });
    _sharedInstance.allowsInvalidSSLCertificate = YES;
    return _sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //custom settings
        [self setDefaultHeader:@"x-api-token" value:kApiToken];
        
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}

@end
