//
//  NetworkReachability.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 8/15/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Reachability.h"

@interface NetworkReachability : NSObject
{
    NSString * reachabilityString;
}

@property (strong, nonatomic) Reachability *internetConnectionReachability;
@property (strong, nonatomic) Reachability *hostReachability;

- (NSString*)currentReachabilityString;
- (BOOL)isReachable;

@end
