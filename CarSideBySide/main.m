//
//  main.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/28/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        NSArray *langOrder = [NSArray arrayWithObjects:@"es-MX", nil];
        [[NSUserDefaults standardUserDefaults] setObject:langOrder forKey:@"AppleLanguages"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
