//
//  CarDetailViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/3/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car;

@interface CarDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate>
{
    IBOutlet UIImageView *carImageView;
    IBOutlet UILabel *modelLabel;
    IBOutlet UITextView *highlighsTextView;

}

@property (strong, nonatomic) Car *car;
@property (nonatomic, weak) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, weak) UIPopoverController *popover;

- (void)selectedCar:(Car *)newCar;

@end
