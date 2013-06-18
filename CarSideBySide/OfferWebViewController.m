//
//  OfferWebViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/17/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "OfferWebViewController.h"

@interface OfferWebViewController ()

@end

@implementation OfferWebViewController

@synthesize webView, url;

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

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:  [NSURL URLWithString:@"http://www.bmw.com.mx"]];
    [webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)reload:(id)sender {
    [self.webView reload];
}

@end
