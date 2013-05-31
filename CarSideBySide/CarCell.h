//
//  CarCell.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/31/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarCell : UICollectionViewCell {
    
    IBOutlet UIImageView *carImageView;
    IBOutlet UILabel *modelNameLabel;
    IBOutlet UITextView *modelHighlightsTextView;
}

@property (strong, nonatomic) id car;

@end
