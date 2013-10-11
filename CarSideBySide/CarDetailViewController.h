//
//  CarDetailViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/3/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car;

@interface CarDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UINavigationControllerDelegate, UINavigationBarDelegate, UIBarPositioningDelegate>
{
    
    IBOutlet UIImageView *carImageView;
    IBOutlet UILabel *modelLabel;
    IBOutlet UITextView *highlighsTextView;

    IBOutlet UIBarButtonItem *technicalDetailsButton;
    IBOutlet UIBarButtonItem *equipmentButton;
    IBOutlet UIBarButtonItem *safetyButton;
    IBOutlet UIBarButtonItem *priceBarButton;
    IBOutlet UIBarButtonItem *linesBarButton;
    
    UINavigationController *navController;

}

@property (strong, nonatomic) Car *car;
@property (nonatomic, weak) IBOutlet UINavigationItem *navBarItem;
@property (nonatomic, weak) IBOutlet UINavigationBar *navBar;
@property (nonatomic, weak) UIPopoverController *popover;

- (void)selectedCar:(Car *)newCar;

@end
