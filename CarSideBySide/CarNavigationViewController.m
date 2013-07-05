//
//  CarNavigationViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/5/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarNavigationViewController.h"
#import "SerieListViewController.h"
#import "CarDetailViewController.h"
@interface CarNavigationViewController ()

@end

@implementation CarNavigationViewController

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
    SerieListViewController *serieListViewController = self.childViewControllers[0];
    serieListViewController.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Car Selection Delegate
-(void)selectedCar:(Car *)newCar
{
    //   [self setCar:newCar];
    if (self.delegate) {
        CarDetailViewController *detailViewController = (CarDetailViewController*)self.delegate;
        [detailViewController selectedCar:newCar];

    }
    
}

@end
