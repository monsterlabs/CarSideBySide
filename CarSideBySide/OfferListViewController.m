//
//  OfferListViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/29/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "OfferListViewController.h"
#import "AppDelegate.h"
#import "OfferCell.h"
#import "OfferListHeaderView.h"
#import "OfferDetailViewController.h"
#import "Offer.h"
#import "CoreDataSeed.h"
#import "NetworkReachability.h"

@interface OfferListViewController () {
    NSMutableArray *results;
    NSString *errors;
}
- (void)configureCell:(OfferCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation OfferListViewController


- (void)reloadData
{
    [results removeAllObjects];
    results = [NSMutableArray arrayWithArray:[[Offer findEnabledOrValidUntil] mutableCopy]];
    [self.collectionView reloadData];
}

- (void)reloadDB
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =  YES;
    dispatch_sync(dispatch_get_main_queue(), ^{
        CoreDataSeed *seed = [[CoreDataSeed alloc] init];
        [seed migrateOffersOrFail:^(NSError* error){
            if (error != nil) {
                errors = [error localizedDescription];
            } else {

            }

        }];
        [self reloadData];
        [UIApplication sharedApplication].networkActivityIndicatorVisible =  NO;
    });
}

- (IBAction)reload:(id)sender
{
    NetworkReachability *networkReachability = [appDelegate networkReachability];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = [NSString localizedStringWithFormat:@"Loading...", nil];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.userInteractionEnabled = NO;
    HUD.delegate = self;
    if ([networkReachability isReachable])
    {
        [HUD showWhileExecuting:@selector(reloadDB) onTarget:self withObject:nil animated:YES];
    } else {
        HUD.labelText = [networkReachability currentReachabilityString];
        [HUD hide:YES afterDelay:2];
        [UIApplication sharedApplication].networkActivityIndicatorVisible =  NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[Offer findEnabledOrValidUntil] count] == 0 ) {
        [self performSelector:@selector(reload:)  withObject:nil afterDelay:1.0];
    } else {
        [self reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ([results count] > 0) ? 1 : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [results count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OfferCell *cell =  [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

# pragma - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    NSManagedObject *object = [results objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"OfferDetailViewController" sender:object ];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

# pragma mark - UICollectionReusableView
- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    OfferListHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                       UICollectionElementKindSectionHeader withReuseIdentifier:@"OfferListHeaderView" forIndexPath:indexPath];
    
    return headerView;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OfferDetailViewController *offerDetailViewController = segue.destinationViewController;
    offerDetailViewController.offer = sender;
}

#pragma mark - UISearchBarDelegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    self.collectionView.allowsSelection = NO;
    self.collectionView.scrollEnabled = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=@"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.collectionView.allowsSelection = YES;
    self.collectionView.scrollEnabled = YES;
    [results removeAllObjects];
    results = [NSMutableArray arrayWithArray:[[Offer findEnabledOrValidUntil] mutableCopy]];
    [self.collectionView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSArray *searchResults = [Offer findTitleLike:searchBar.text];
    if ([searchResults count] > 0) {
        [results removeAllObjects];
        results = [searchResults mutableCopy];
    }
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.collectionView.allowsSelection = YES;
    self.collectionView.scrollEnabled = YES;
    [self.collectionView reloadData];
}

- (void)configureCell:(OfferCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [results objectAtIndex:indexPath.row];
    cell.offer = object;
}
@end
