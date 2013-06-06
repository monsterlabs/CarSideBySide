//
//  DummyViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/6/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DummyViewController : UIViewController {
    IBOutlet UIImageView *dummyImageView;
    IBOutlet UILabel *modelNameLabel;
    IBOutlet UILabel *sectionTitleLabel;
}

@property (nonatomic, retain) NSString *modelName;
@property (nonatomic, retain) NSString *sectionTitle;
@property (nonatomic, retain) NSString *dummyImage;


@end
