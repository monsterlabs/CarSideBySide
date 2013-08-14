//
//  CarCatalogApiClient.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 8/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <AFNetworking.h>

@interface CarCatalogApiClient : AFHTTPClient

+ (id)sharedInstance;

@end
