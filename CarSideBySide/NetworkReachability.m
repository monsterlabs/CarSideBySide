//
//  NetworkReachability.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 8/15/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "NetworkReachability.h"
#import "AppDelegate.h"
@implementation NetworkReachability

@synthesize internetConnectionReachability, hostReachability;

- (id) init
{
    internetConnectionReachability = [Reachability reachabilityForInternetConnection];
    hostReachability  = [Reachability reachabilityWithHostname:cHost];
    reachabilityString = NSLocalizedString(@"The network status isUnknown", nil);
    return self;
}


- (BOOL)isReachable {
    BOOL status = NO;
    
    if ([internetConnectionReachability isReachable] && [hostReachability isReachable])
    {
        status = YES;
        reachabilityString = NSLocalizedString(@"The network connection is OK", nil);
    }
    else if ([internetConnectionReachability isReachable]  && ![hostReachability isReachable])
        reachabilityString = NSLocalizedString(@"The server connection is not available", nil);
    else if (![internetConnectionReachability isReachable])
        reachabilityString = NSLocalizedString(@"The network connection is not available", nil);
    
    return status;
}

- (NSString*)currentReachabilityString
{
    return reachabilityString;
}

@end
