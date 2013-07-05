//
//  CarSplitViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/5/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarSplitViewController.h"
#import "CarDetailViewController.h"
#import "CarNavigationViewController.h"
@interface CarSplitViewController ()

@end

@implementation CarSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CarNavigationViewController *carNavigationController = self.viewControllers[0];
    CarDetailViewController *carDetailViewController = self.viewControllers.lastObject;
    
    carNavigationController.delegate = carDetailViewController;
    self.delegate = carDetailViewController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
