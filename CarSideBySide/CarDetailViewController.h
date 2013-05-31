//
//  CarDetailViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/31/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarDetailViewController : UIViewController{
    IBOutlet UIImageView *largeImageView;
    IBOutlet UILabel *modelNameLabel;
}

@property (strong, nonatomic) id car;

@end
