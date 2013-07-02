//
//  CarDetailViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/31/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarDetailViewController.h"
#import "Car.h"
#import <QuartzCore/QuartzCore.h>
@interface CarDetailViewController ()

@end

@implementation CarDetailViewController

-(void)setCar:(id)newCar
{
    if (_car != newCar) {
        _car = newCar;
    }
}

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
    int year = [[self.car valueForKey: @"year"] integerValue];

    modelNameLabel.text =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    largeImageView.image = [UIImage imageNamed:[self.car valueForKey:@"largeImage"]];
    largeImageView.layer.masksToBounds = YES;
    largeImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    largeImageView.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
