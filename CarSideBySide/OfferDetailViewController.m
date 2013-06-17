//
//  OfferDetailViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/1/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "OfferDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "OfferWebViewController.h"
@interface OfferDetailViewController ()

@end

@implementation OfferDetailViewController

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
    titleLabel.text = [self.offer valueForKey:@"title"];
    titleLabel.font = [UIFont fontWithName:@"BMWTypeGlobalPro-Bold" size:18.0];

    bodyTextView.text = [self.offer valueForKey:@"body"];
    bodyTextView.font = [UIFont fontWithName:@"BMWTypeGlobalPro-Regular" size:14.0];

    offerImageView.image = [UIImage imageNamed:[self.offer valueForKey:@"largeImage"]];
    offerImageView.layer.cornerRadius = 05.0f;
    offerImageView.layer.masksToBounds = YES;
    offerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    offerImageView.layer.borderWidth = 1.0;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[self.offer valueForKey:@"validUntil"]];
    validUntilLabel.text = dateString;
    validUntilLabel.font = [UIFont fontWithName:@"BMWTypeGlobalPro-Light" size:11.0];
    validDateLabel.font = [UIFont fontWithName:@"BMWTypeGlobalPro-Bold" size:11.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OfferWebViewController *offerWebViewController = segue.destinationViewController;
    offerWebViewController.url = [self.offer valueForKey:@"url"];
}


@end
