//
//  OfferCell.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "OfferCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation OfferCell

-(void)setOffer:(id)newOffer
{
    if (_offer != newOffer) {
        _offer = newOffer;
    }
    [self configureCell];    
}

- (void)configureCell {
    titleLabel.text = [self.offer valueForKey:@"title"];
    titleLabel.font = [UIFont fontWithName:@"BMWTypeGlobalPro-Bold" size:18.0];
    bodyTextView.text = [self.offer valueForKey:@"body"];
    bodyTextView.font = [UIFont fontWithName:@"BMWTypeGlobalPro-Regular" size:14.0];
    
    offerImageView.image = [UIImage imageNamed:[self.offer valueForKey:@"image"]];
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
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self configureCell];
    [super drawRect:rect];
}

@end
