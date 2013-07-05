//
//  CarCell.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Car.h"
@interface CarCell : UITableViewCell {
    IBOutlet UILabel *title;
    IBOutlet UILabel *subTitle;
}

@property (strong, nonatomic) Car *car;

@end
