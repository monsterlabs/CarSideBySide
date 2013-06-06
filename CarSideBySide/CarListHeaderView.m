//
//  CarListHeaderView.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/6/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarListHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CarListHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //[theSegmentedControl removeAllSegments];
    NSArray *itemArray = [NSArray arrayWithObjects: @"Sedan", @"Coupe", @"Convertible", nil];
    theSegmentedControl = [[UISegmentedControl alloc] initWithItems: itemArray];
    [theSegmentedControl setSegmentedControlStyle:UISegmentedControlStyleBezeled];
    [theSegmentedControl sizeToFit];
    theSegmentedControl.frame = CGRectMake(self.frame.origin.x + (self.bounds.size.width / 4), self.frame.origin.y + 55, self.bounds.size.width / 2, 44);

//    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview: theSegmentedControl];

    [super drawRect:rect];
}

@end
