//
//  CarListViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarListViewController.h"
#import "AppDelegate.h"
#import "Line.h"
#import "Car.h"
#import "NSManagedObject+Find.h"
#import "CarCell.h"
#import <DVCoreDataFinders.h>

@interface CarListViewController ()

@property (nonatomic) NSMutableArray *data;
@property (nonatomic) NSMutableArray *filteredData;
@end

@implementation CarListViewController

@synthesize data, filteredData;

- (void)setSerie:(Serie *)serie {
    if (_serie != serie) {
        _serie = serie;
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.serie.name;
    self.data = [NSMutableArray array];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

    NSSortDescriptor *sortLineDescriptor = [[NSSortDescriptor alloc] initWithKey:@"modelName" ascending:YES];
    NSArray *sortLines = [[NSArray alloc] initWithObjects:sortLineDescriptor, nil];

    for (Line *line in [self.serie.lines sortedArrayUsingDescriptors:sortDescriptors])
    {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys: line, @"line", [line.cars sortedArrayUsingDescriptors:sortLines], @"cars", nil];
        [data addObject:dict];
    }
    [self.filteredData removeAllObjects];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
    tempView.backgroundColor=[UIColor viewFlipsideBackgroundColor];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(5,0,300,32)];
    tempLabel.backgroundColor=[UIColor viewFlipsideBackgroundColor];
    tempLabel.shadowColor = [UIColor darkGrayColor];
    tempLabel.shadowOffset = CGSizeMake(0,2);
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.font = [UIFont boldSystemFontOfSize:16.0];
    Line *line = [self lineWithTableView:tableView inSection:section];
    tempLabel.text= line.name;
    
    [tempView addSubview:tempLabel];
    return tempView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return [self.filteredData count];
    else
        return [self.data count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return [[[self.filteredData objectAtIndex:section] objectForKey:@"cars"] count];
    else
        return [[[self.data objectAtIndex:section] objectForKey:@"cars"] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CarCell";
    CarCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.car = [self carWithTableView:tableView AtIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    Line *line = [self lineWithTableView:tableView inSection:section];
    return line.name;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Car *selectedCar = [self carWithTableView:tableView AtIndexPath:indexPath];
    if (_delegate) {
        [_delegate selectedCar:selectedCar];
    }
    
}

# pragma mark - Filtering methods
- (Car *)carWithTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return (Car *)[[[self.filteredData objectAtIndex:indexPath.section] objectForKey:@"cars"] objectAtIndex:indexPath.row];
    else
        return (Car *)[[[self.data objectAtIndex:indexPath.section] objectForKey:@"cars"] objectAtIndex:indexPath.row];
}

- (Line *)lineWithTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return (Line*)[[self.filteredData objectAtIndex:section] objectForKey:@"line"];
    else
        return (Line*)[[self.data objectAtIndex:section] objectForKey:@"line"];
}

- (void)filterData:(NSString*)searchString;
{
    self.filteredData = [NSMutableArray array];
    for (NSDictionary *dict in self.data){
        NSMutableArray *cars = [NSMutableArray array];
        for (Car *car in [dict objectForKey:@"cars"])
        {
            BOOL match = NO;
            NSPredicate *containPred = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString];
            match = match | [containPred evaluateWithObject:car.model];
            if (match) {
                [cars addObject:car];
            }
        }
        
        NSDictionary *newDict = [NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"carModel"], @"carModel", cars, @"cars", nil];
        [self.filteredData addObject:newDict];
    }
}
#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self filterData:searchString];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = [self.searchDisplayController.searchBar text];
    
    [self filterData:searchString];
    return YES;
}


@end
