//
//  SerieListViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/6/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CarSelectionDelegate.h"
#import <MBProgressHUD.h>

@interface SerieListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, CarSelectionDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}

@property (nonatomic, assign) id<CarSelectionDelegate> delegate;

@end
