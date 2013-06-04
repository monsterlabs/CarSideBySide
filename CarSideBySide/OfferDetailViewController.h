//
//  OfferDetailViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 6/1/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferDetailViewController : UIViewController
{
    IBOutlet UIImageView *offerImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextView *bodyTextView;
    IBOutlet UILabel *validUntilLabel;
    IBOutlet UILabel *urlLabel;
}

@property (strong, nonatomic) id offer;
-(IBAction)done:(id) sender;
@end
