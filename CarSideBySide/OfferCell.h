//
//  OfferCell.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferCell : UICollectionViewCell
{
    IBOutlet UIImageView *offerImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextView *bodyTextView;
    IBOutlet UILabel *validDateLabel;
    IBOutlet UILabel *validUntilLabel;
}

@property (strong, nonatomic) id offer;

- (void)configureCell;
@end
