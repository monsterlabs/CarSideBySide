//
//  OfferCell.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
@interface OfferCell : UICollectionViewCell
{
    IBOutlet UIImageView *offerImageView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UITextView *bodyTextView;
    IBOutlet UILabel *validUntilLabel;
}

@property (nonatomic, strong) Offer *offer;

@end
