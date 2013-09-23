//
//  OfferCell.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "OfferCell.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "NetworkReachability.h"
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
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[self.offer valueForKey:@"image"]];

    if(![fileManager fileExistsAtPath:imagePath])
    {
        NSString *dummyImagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"../CarSideBySide.app/offer_dummy.jpg"];
        NSData *data = [NSData dataWithContentsOfFile:dummyImagePath];
        offerImageView.image = [UIImage imageWithData:data];
        
        NetworkReachability *networkReachability = [appDelegate networkReachability];
        if ([networkReachability isReachable])
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible =  YES;
            [AFImageDownloader imageDownloaderWithURLString:[self.offer valueForKey:@"imageUrl"] autoStart:YES completion:^(UIImage *decompressedImage) {
                NSData *binaryImage = UIImageJPEGRepresentation(decompressedImage, 0.8);
                [binaryImage writeToFile:imagePath atomically:YES];
                offerImageView.image = decompressedImage;
                [UIApplication sharedApplication].networkActivityIndicatorVisible =  NO;
            }];
        }
    } else {
        NSData *data = [NSData dataWithContentsOfFile:imagePath];
        offerImageView.image = [UIImage imageWithData:data];
    }

    offerImageView.layer.cornerRadius = 03.0f;
    offerImageView.layer.masksToBounds = YES;
    offerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    offerImageView.layer.borderWidth = 1.0;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[self.offer valueForKey:@"validUntil"]];
    validUntilLabel.text = dateString;
    self.layer.cornerRadius = 03.0f;
    self.layer.masksToBounds = YES;
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0;

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
