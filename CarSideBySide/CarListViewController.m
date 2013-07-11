//
//  CarListViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarListViewController.h"
#import "AppDelegate.h"
#import "CarModel.h"
#import "Car.h"
#import "NSManagedObject+Find.h"
#import "CarCell.h"
#import <DVCoreDataFinders.h>

@interface CarListViewController () {

    NSArray *carModels;
    NSDictionary *tableOfContents;
}

@end

@implementation CarListViewController

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
    carModels = [self.serie.carModels allObjects];
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
    tempLabel.text= [[carModels objectAtIndex:section] name];
    
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
    return [carModels count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarModel *carModel = [carModels objectAtIndex:section];
    return [[carModel.cars allObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CarCell";
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    CarModel *carModel = [carModels objectAtIndex:indexPath.section];
    cell.car = [[carModel.cars allObjects] objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[carModels objectAtIndex:section] name];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarModel *carModel = [carModels objectAtIndex:indexPath.section];
    Car *selectedCar = [[carModel.cars allObjects] objectAtIndex:indexPath.row];
    if (_delegate) {
        [_delegate selectedCar:selectedCar];
    }
}


@end
