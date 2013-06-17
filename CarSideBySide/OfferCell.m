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
    bodyTextView.text = [self.offer valueForKey:@"body"];
    
    offerImageView.image = [UIImage imageNamed:[self.offer valueForKey:@"image"]];
    offerImageView.layer.cornerRadius = 05.0f;
    offerImageView.layer.masksToBounds = YES;
    offerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    offerImageView.layer.borderWidth = 1.0;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[self.offer valueForKey:@"validUntil"]];
    validUntilLabel.text = dateString;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 266, self.contentView.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview: lineView];

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
