//
//  CarCatalogAPIClient.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/20/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarCatalogAPIClient.h"

//static NSString * const kAFIncrementalStoreCarCatalogAPIBaseURLString = @"http://catalog.bmwapps.mx/api/v1";
static NSString * const kAFIncrementalStoreCarCatalogAPIBaseURLString = @"http://localhost:3000/api/v1";
@implementation CarCatalogAPIClient

+ (CarCatalogAPIClient *)sharedClient {
    static CarCatalogAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAFIncrementalStoreCarCatalogAPIBaseURLString]];
    });
    _sharedClient.allowsInvalidSSLCertificate = YES;
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.operationQueue.suspended = (status == AFNetworkReachabilityStatusNotReachable);
    }];
    
    return self;
}

- (NSDictionary *)attributesForRepresentation:(NSDictionary *)representation
                                     ofEntity:(NSEntityDescription *)entity
                                 fromResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mutablePropertyValues = [[super attributesForRepresentation:representation ofEntity:entity fromResponse:response] mutableCopy];
    if ([entity.name isEqualToString:@"Offer"]) {
        NSString *imageUrl = [representation valueForKey:@"imageUrl"];
        NSString *fileImage = [representation valueForKey:@"image"];
        [self saveImage:imageUrl fileImage:fileImage];
        //[mutablePropertyValues setValue:imagePath forKey:@"image"];
        
        NSString *largeImageUrl = [representation valueForKey:@"largeImageUrl"];
        NSString *fileLargeImage = [representation valueForKey:@"largeImage"];
        [self saveImage:largeImageUrl fileImage:fileLargeImage];

    } else if ([entity.name isEqualToString:@"Car"]) {
        NSString *imageUrl = [representation valueForKey:@"imageUrl"];
        NSString *fileImage = [representation valueForKey:@"image"];
        [self saveImage:imageUrl fileImage:fileImage];
        
    }
    return mutablePropertyValues;
}


- (void)saveImage:(NSString *)imageURL fileImage:(NSString *)fileImage
{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileImage];
    [imageData writeToFile:imagePath atomically:YES];
}

@end
