//
//  CarListViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Serie.h"
#import "CarSelectionDelegate.h"
@interface CarListViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) Serie *serie;
@property (nonatomic, assign) id<CarSelectionDelegate> delegate;

@end
