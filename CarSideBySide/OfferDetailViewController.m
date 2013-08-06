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

-(void)setOffer:(id)newOffer
{
    if (_offer != newOffer) {
        _offer = newOffer;
    }
    [self configureView];
}

- (void)configureView
{
    titleLabel.text = [self.offer valueForKey:@"title"];

    bodyTextView.text = [self.offer valueForKey:@"body"];
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[self.offer valueForKey:@"largeImage"]];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    offerImageView.image = [UIImage imageWithData:data];
    offerImageView.layer.cornerRadius = 03.0f;
    offerImageView.layer.masksToBounds = YES;
    offerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    offerImageView.layer.borderWidth = 1.0;

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[self.offer valueForKey:@"validUntil"]];
    validUntilLabel.text = dateString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
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
