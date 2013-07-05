//
//  CarCell.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell

- (void)setCar:(Car *)car {
    if (_car != car) {
        _car = car;
    }
    [self configureCell];
}

- (void)configureCell
{
    title.text = [self.car model];
    subTitle.text = self.car.highlights;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureCell];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
