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
    IBOutlet UIBarButtonItem *technicalDetailButton;
}

@property (strong, nonatomic) id car;

- (IBAction)showEquipment:(id)sender;
- (IBAction)showLines:(id)sender;
- (IBAction)showPrice:(id)sender;
- (IBAction)showSafety:(id)sender;
- (IBAction)showTechnicalDetail:(id)sender;
@end
