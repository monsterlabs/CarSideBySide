//
//  AppDelegate.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/28/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "AppDelegate.h"
#import <YISplashScreen.h>
#import <YISplashScreen+Migration.h>
#import <YISplashScreenAnimation.h>
#import <MBHUDView.h>
#import "CoreDataStack.h"
#import "TestFlight.h"
#import "CoreDataSeed.h"
#import "NetworkReachability.h"
#import "CarCatalogApiClient.h"
#import "Car.h"
#import "Offer.h"
#import "NSManagedObject+Find.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize coreDataStack = _coreDataStack;
@synthesize networkReachability = _networkReachability;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [TestFlight takeOff:@"f3572086-e23b-4000-9b2d-0588b47d30b3"];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    [YISplashScreen show];
    
    _coreDataStack = [CoreDataStack coreDataStackWithModelName:@"CarSideBySide"];
    _coreDataStack.coreDataStoreType = CDSStoreTypeSQL;
    _managedObjectContext = _coreDataStack.managedObjectContext;
    _networkReachability = [[NetworkReachability alloc] init];
    
    [YISplashScreen waitForMigration:nil completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
            [YISplashScreen hideWithAnimation:[YISplashScreenAnimation cubeAnimation]];
        else
            [YISplashScreen hideWithAnimation:[YISplashScreenAnimation pageCurlAnimation]];
        
    }];
    
    if (launchOptions != nil)
	{
		NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (dictionary != nil)
		{
			NSLog(@"Launched from push notification: %@", dictionary);
			[self addMessageFromRemoteNotification:dictionary updateUI:NO];
		}
	}
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if (([[Car findAll] count] > 0 ) || ([[Offer findAll] count] > 0)) {
        [self doPendingNotification];
    }
}

- (void)doPendingNotification {
    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0)
    {
        NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        if (userInfo != nil)
            [self addMessageFromRemoteNotification:userInfo updateUI:YES];
    }
    
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSDictionary *params = [self paramsWithDeviceToken:deviceToken];
    AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
    NSURL *url = [NSURL URLWithString:@"push_notification_devices.json"];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:[url path] parameters:params];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NetworkReachability *networkReachability = [appDelegate networkReachability];
    if ([networkReachability isReachable])
    {
        [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if(error) {
            NSLog(@"Error %@", error);
        } else {
            NSLog(@"The token was registered in the remote server: %@", cHost);
        }
    }
}

- (NSDictionary *)paramsWithDeviceToken:(NSData*)deviceToken
{
    NSNumber *badge = [NSNumber numberWithInt:[UIApplication sharedApplication].applicationIconBadgeNumber];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSDictionary dictionaryWithObjectsAndKeys:
                             deviceToken, @"token",
                             [NSTimeZone localTimeZone], @"timezone",
                             badge, @"badge",
                             nil ], @"push_notification_device",
                            nil ];
    return params;
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
	NSLog(@"Received notification: %@", userInfo);
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        // do stuff when app is active
        [self addMessageFromRemoteNotification:userInfo updateUI:YES];
        [self updateRemoteDeviceInfo:userInfo];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:userInfo forKey:@"userInfo"];
        
    }else{
        // do stuff when app is in background
        NSString *badgeNumber = [[userInfo valueForKey:@"aps"] valueForKey:@"badge"];
        [UIApplication sharedApplication].applicationIconBadgeNumber = [badgeNumber integerValue];
    }
    
}

- (void)addMessageFromRemoteNotification:(NSDictionary*)userInfo updateUI:(BOOL)updateUI
{
    
	NSString *alertValue = NSLocalizedString(@"La base de datos fue actualizada", nil);
    NSString *questionValue = NSLocalizedString(@"¿Quieres descargar los cambios?", nil);
    NSString *alertMessage = [NSString stringWithFormat:@"%@. %@", alertValue, questionValue];
    
    __block MBAlertView *alert = [MBAlertView alertWithBody:alertMessage cancelTitle: NSLocalizedString(@"Cancelar",nil) cancelBlock:nil];
    alert.title = alertValue;
    alert.size = CGSizeMake(380, 280);
    [alert addButtonWithText: NSLocalizedString(@"Sí", nil) type:MBAlertViewItemTypePositive block:^{
        [alert dismiss];
        if ([[userInfo valueForKey:@"updated_section"] isEqualToString:@"offer"])
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadOffers" object:nil];
        else
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadComparatives" object:nil];
    }];
    [alert addToDisplayQueue];
    
}

- (void)updateRemoteDeviceInfo:(NSDictionary*)userInfo
{
    if (userInfo != nil) {
        NSDictionary *params = [ NSDictionary dictionaryWithObjectsAndKeys:
                                [ NSDictionary dictionaryWithObjectsAndKeys:
                                 0, @"badge",
                                 nil ], @"push_notification_device",
                                nil ];
        
        AFHTTPClient *httpClient = [CarCatalogApiClient sharedInstance];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:
                                           @"push_notification_devices/%@.json", [userInfo valueForKey:@"device_id"]]];
        
        [httpClient putPath:[url path]
                 parameters: params
                    success:^(AFHTTPRequestOperation *operation, id responseObject){
                        NSLog(@"RESPonsee %@",responseObject);
                    }
                    failure:^(AFHTTPRequestOperation *operation, NSError *error){
                        NSLog(@"ERROR %@",[error localizedDescription]);
                        
                    }
         ];
    }
}

@end
