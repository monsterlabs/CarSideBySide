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
#import "DummyViewController.h"
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


- (IBAction)showEquipment:(id)sender;
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    DummyViewController *dummyController = (DummyViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"DummyViewController"];
    dummyController.sectionTitle = @"Equipment";
    int year = [[self.car valueForKey: @"year"] integerValue];
    dummyController.sectionTitle =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    dummyController.dummyImage = @"equipment.png";
    [self.navigationController pushViewController:dummyController animated:YES];
}

- (IBAction)showLines:(id)sender;
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    DummyViewController *dummyController = (DummyViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"DummyViewController"];
    dummyController.sectionTitle = @"Lines";
    int year = [[self.car valueForKey: @"year"] integerValue];
    dummyController.sectionTitle =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    dummyController.dummyImage = @"lines.png";
    [self.navigationController pushViewController:dummyController animated:YES];
}

- (IBAction)showPrice:(id)sender;
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    DummyViewController *dummyController = (DummyViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"DummyViewController"];
    dummyController.sectionTitle = @"Price";
    int year = [[self.car valueForKey: @"year"] integerValue];
    dummyController.sectionTitle =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    dummyController.dummyImage = @"price.png";
    [self.navigationController pushViewController:dummyController animated:YES];
}

- (IBAction)showSafety:(id)sender;
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    DummyViewController *dummyController = (DummyViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"DummyViewController"];
    dummyController.sectionTitle = @"Safety";
    int year = [[self.car valueForKey: @"year"] integerValue];
    dummyController.sectionTitle =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    dummyController.dummyImage = @"safety.png";
    [self.navigationController pushViewController:dummyController animated:YES];
}

- (IBAction)showTechnicalDetail:(id)sender;
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
    
    DummyViewController *dummyController = (DummyViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"DummyViewController"];
    dummyController.sectionTitle = @"Tecnical detail";
    int year = [[self.car valueForKey: @"year"] integerValue];
    dummyController.sectionTitle =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    dummyController.dummyImage = @"technical_details.png";
    [self.navigationController pushViewController:dummyController animated:YES];
}


@end
