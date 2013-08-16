//
//  AppDelegate.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/28/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataStack.h"
#import "NetworkReachability.h"

#define appDelegate (AppDelegate *) [[UIApplication sharedApplication] delegate]
#define cHost @"catalog.bmwapps.mx"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{

}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) CoreDataStack *coreDataStack;
@property (strong, nonatomic) NetworkReachability  *networkReachability;
@end
