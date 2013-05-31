//
//  CarCell.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/31/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarCell.h"
#import "Car.h"
#import <QuartzCore/QuartzCore.h>

@implementation CarCell

-(void)setCar:(id)newCar
{
    if (_car != newCar) {
        _car = newCar;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{

    int year = [[self.car valueForKey: @"year"] integerValue];
    NSString *modelHighlights = [NSString stringWithFormat:@"By definition, it's authentic performance encased in a premium package. But embodied, it's the newest 1 Series. Let us introduce you to the %d %@ and all of its 230 horses, exterior design enhancements, sophisticated interior accents, and the innovations of BMW EfficientDynamics. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a tellus a ipsum adipiscing mattis quis et arcu. Praesent ultrices ultrices eleifend. Donec viverra, libero sit amet lacinia luctus, dui elit ornare urna, at mattis enim nisi nec sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a tellus a ipsum adipiscing mattis quis et arcu. Praesent ultrices ultrices eleifend. Donec viverra, libero sit amet lacinia luctus, dui elit ornare urna, at mattis enim nisi nec sem.", year, [self.car valueForKey: @"modelName"] ];

    modelNameLabel.text =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    modelHighlightsTextView.text = modelHighlights;
    carImageView.image = [UIImage imageNamed:[self.car valueForKey:@"image"]];
    //carImageView.layer.cornerRadius = 10.0f;
    carImageView.layer.masksToBounds = YES;
    carImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    carImageView.layer.borderWidth = 1.0;

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 477, self.contentView.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview: lineView];

    [super drawRect:rect];
}

@end
