//
//  OfferCell.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "OfferCell.h"

@implementation OfferCell
@synthesize offer;

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
    NSLog(@"TITLE %@", offer.title);
    titleLabel.text = offer.title;
    bodyTextView.text = self.offer.body;
    offerImageView.image = [UIImage imageNamed:self.offer.image];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:self.offer.validUntil];
    validUntilLabel.text = dateString;
    [super drawRect:rect];
}

@end
