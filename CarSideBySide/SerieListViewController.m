//
//  SerieListViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/6/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "SerieListViewController.h"
#import "AppDelegate.h"
#import "Serie.h"
#import "CarListViewController.h"
#import "CoreDataSeed.h"
@interface SerieListViewController ()
{
    NSMutableArray *results;
}
@end

@implementation SerieListViewController

- (void) reloadData
{
    results = [NSMutableArray arrayWithArray:[Serie findAllEnabled]];
    [self.tableView reloadData];
}

- (IBAction)reload:(id)sender
{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = [NSString localizedStringWithFormat:@"Loading...", nil];
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.02 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        CoreDataSeed *seed = [[CoreDataSeed alloc] init];
        [seed migrateCarComparativesOrFail:^(NSError* error){
            if (error != nil)
                HUD.labelText = [error localizedDescription];
        }];        
        [self reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[Serie findAllEnabled] count] == 0 ) {
        [self performSelector:@selector(reload:)  withObject:nil afterDelay:1.0];
    }
    else {
        [self reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ([results count] > 0) ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [results count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SerieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSManagedObject *object = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = [object valueForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Serie *serie = [results objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"CarListViewController" sender:serie ];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CarListViewController *carListViewController = segue.destinationViewController;
    carListViewController.serie = sender;
    carListViewController.delegate = self;
}

#pragma mark - Car Selection Delegate
-(void)selectedCar:(Car *)newCar
{
    if (_delegate) {
        [_delegate selectedCar:newCar];
    }
}


@end
