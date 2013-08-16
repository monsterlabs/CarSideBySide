//
//  OfferListViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MBProgressHUD.h>

@interface OfferListViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate, MBProgressHUDDelegate> {
    UISearchBar *theSearchBar;
    MBProgressHUD *HUD;

}
- (IBAction)reload:(id)sender;
@end
