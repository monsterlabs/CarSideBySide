//
//  SpecComparisonsViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/9/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWMultiColumnTableView.h"

@class Specification;

@interface ComparativeViewController : UIViewController <EWMultiColumnTableViewDataSource> {
    NSMutableArray *data;
    NSMutableArray *sectionHeaderData;
    
    
    CGFloat colWidth;
    NSInteger numberOfSections;
    NSInteger numberOfColumns;
    
    EWMultiColumnTableView *tblView;
}

@property (strong, nonatomic) Specification *specification;
@property (strong, nonatomic) NSMutableArray *columnNamesPerRow;
@property (strong, nonatomic) NSMutableArray *myheaders;

@end
