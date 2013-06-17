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

@interface OfferListViewController () {
    NSMutableArray *results;
}
- (void)configureCell:(OfferCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation OfferListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    results = [[Offer findEnabledOrValidUntil] mutableCopy];
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
