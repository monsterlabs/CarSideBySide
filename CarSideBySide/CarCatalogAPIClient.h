//
//  CarCatalogAPIClient.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/20/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//
#import <SystemConfiguration/SystemConfiguration.h>
#import <AFRESTClient.h>
#import <AFIncrementalStore.h>

@interface CarCatalogAPIClient : AFRESTClient <AFIncrementalStoreHTTPClient>

+ (CarCatalogAPIClient *)sharedClient;

@end
