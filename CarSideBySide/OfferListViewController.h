//
//  OfferListViewController.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface OfferListViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

}
@property (readonly, strong, nonatomic) NSArray *offers;
@end
