//
//  DummyViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/6/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "DummyViewController.h"

@interface DummyViewController ()

@end

@implementation DummyViewController
@synthesize sectionTitle, modelName, dummyImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
            NSLog(@"initWithNibName");
    return self;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"viewDidLoad %@",sectionTitle);
    sectionTitleLabel.text = sectionTitle;
    modelNameLabel.text = modelName;
    dummyImageView.image = [UIImage imageNamed:dummyImage];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
