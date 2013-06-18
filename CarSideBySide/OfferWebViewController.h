//
//  OfferWebViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/17/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferWebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *url;

- (IBAction)done:(id)sender;
- (IBAction)reload:(id)sender;
@end
