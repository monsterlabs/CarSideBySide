//
//  CarCell.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/31/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarCell.h"
#import "Car.h"

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
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    int year = [[self.car valueForKey: @"year"] integerValue];
    NSString *modelHighlights = [NSString stringWithFormat:@"By definition, it's authentic performance encased in a premium package. But embodied, it's the newest 1 Series. Let us introduce you to the %d %@ and all of its 230 horses, exterior design enhancements, sophisticated interior accents, and the innovations of BMW EfficientDynamics.", year, [self.car valueForKey: @"modelName"] ];

    modelNameLabel.text =  [NSString stringWithFormat: @"%@ %d", [self.car valueForKey: @"modelName"], year];
    modelHighlightsTextView.text = modelHighlights;
    carImageView.image = [UIImage imageNamed:[self.car valueForKey:@"image"]];
    [super drawRect:rect];
}

@end
