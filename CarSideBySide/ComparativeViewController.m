//
//  SpecComparisonsViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/9/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "ComparativeViewController.h"
#import "Car.h"
#import "Specification.h"
#import "SpecificationType.h"
#import "Comparative.h"
#import "ComparedCar.h"
#import "Feature.h"
#import "ComparedFeature.h"
#import "NSObject+DelayedBlock.h"

@interface ComparativeViewController ()

@end
#define ROWS 100

@implementation ComparativeViewController

- (void)setSpecification:(Specification *)newSpecification {
    if (_specification != newSpecification) {
        _specification = newSpecification;
    }
    [self fillTable];
}

- (void)fillTable
{
    self.myheaders = [NSMutableArray array];
    [self.myheaders addObject:self.specification.car.modelWithBrand];
    NSSortDescriptor *idSorter = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES];
    NSArray *comparatives = [[self.specification.comparatives allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:idSorter]];
    for (Comparative *comparative in comparatives) {
        [self.myheaders addObject:comparative.comparedCar.model];
    }
    numberOfColumns = [self.specification.comparatives count] +1;
    
    data = [[NSMutableArray alloc] initWithCapacity:numberOfSections * 5];
    self.columnNamesPerRow = [NSMutableArray arrayWithCapacity:numberOfSections * 5];
    sectionHeaderData = [[NSMutableArray alloc] initWithCapacity:numberOfSections];
    NSSortDescriptor *comparativeIdSorter = [NSSortDescriptor sortDescriptorWithKey:@"comparative.id" ascending:YES];
    for (int i = 0; i < numberOfSections; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *rowNames = [NSMutableArray array];
        NSSortDescriptor *sequenceSorter = [NSSortDescriptor sortDescriptorWithKey:@"sequence" ascending:YES];
        NSArray *features = [[self.specification.features allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sequenceSorter]];
        for (Feature *feature in features) {

            NSMutableArray *rowArray = [NSMutableArray arrayWithCapacity:numberOfColumns];
            [rowArray addObject:feature.descr];
            
            NSArray *comparedFeatures = [[feature.comparedFeatures allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObject:comparativeIdSorter]];
            for (ComparedFeature *comparedFeature in comparedFeatures) {
                [rowArray addObject:comparedFeature.descr];
            }
            [sectionArray addObject:rowArray];
            NSArray *cellTitle = [NSArray arrayWithObjects:feature.nameORAdditionalInfo, feature.highlighted, nil];
            [rowNames addObject:cellTitle];
            
        }
        [self.columnNamesPerRow addObject:rowNames];
        [data addObject:sectionArray];
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        srand(time(0));
    }
    
    return self;
}


- (void)dealloc
{
    [data release];
    [tblView release];
    [sectionHeaderData release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    numberOfSections = 1;
    colWidth = 250.0f;
    [self fillTable];
    tblView = [[EWMultiColumnTableView alloc] initWithFrame:CGRectInset(self.view.bounds, 5.0f, 5.0f)];
    tblView.sectionHeaderEnabled = NO;
    tblView.topHeaderBackgroundColor = [UIColor colorWithWhite:249.0f/255.0f alpha:1.0f];
    //    tblView.cellWidth = 100.0f;
    //    tblView.boldSeperatorLineColor = [UIColor blueColor];
    //    tblView.normalSeperatorLineColor = [UIColor blueColor];
    //    tblView.boldSeperatorLineWidth = 10.0f;
    //    tblView.normalSeperatorLineWidth = 10.0f;
    tblView.dataSource = self;
    tblView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:tblView];
    
    [self performBlock:^{
        
        [tblView scrollToColumn:0 position:EWMultiColumnTableViewColumnPositionMiddle animated:YES];
    } afterDelay:0.5];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    // e.g. self.myOutlet = nil;
    [tblView release];
    tblView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - EWMultiColumnTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(EWMultiColumnTableView *)tableView
{
    return numberOfSections;
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView cellForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, (colWidth -10.0f), 40.0f)] autorelease];
    l.numberOfLines = 0;
    l.lineBreakMode = NSLineBreakByWordWrapping;
    
    return l;
}


- (void)tableView:(EWMultiColumnTableView *)tableView setContentForCell:(UIView *)cell indexPath:(NSIndexPath *)indexPath column:(NSInteger)col{
    UILabel *l = (UILabel *)cell;
    l.text = [[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:col];
    l.font = [UIFont systemFontOfSize:13.0];
    
    CGRect f = CGRectMake(l.frame.origin.x, l.frame.origin.y, l.frame.size.width, l.frame.size.height);
    f.size.width = [self tableView:tableView widthForColumn:col] - 10;
    l.frame = f;
    [l sizeToFit];
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForCellAtIndexPath:(NSIndexPath *)indexPath column:(NSInteger)col
{
    NSString *str = [[[data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:col];
    if (str.length == 0)
        str = @"-";
    CGSize s = [str sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]
               constrainedToSize:CGSizeMake([self tableView:tableView widthForColumn:col], MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    return s.height + 10.0f;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView widthForColumn:(NSInteger)column
{
    return colWidth;
}

- (NSInteger)tableView:(EWMultiColumnTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[data objectAtIndex:section] count];
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView sectionHeaderCellForSection:(NSInteger)section column:(NSInteger)col
{
    UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [self tableView:tableView widthForColumn:col], 0.0f)] autorelease];
    // l.backgroundColor = [UIColor yellowColor];
    l.text =@"";
    return l;
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForSectionHeaderCell:(UIView *)cell section:(NSInteger)section column:(NSInteger)col
{
    UILabel *l = (UILabel *)cell;
    // l.text = [NSString stringWithFormat:@"S %d C %d", section, col];
    l.text = @"";
    
    CGRect f = l.frame;
    f.size.width = [self tableView:tableView widthForColumn:col];
    l.frame = f;
    
    [l sizeToFit];
}

- (NSInteger)numberOfColumnsInTableView:(EWMultiColumnTableView *)tableView
{
    return numberOfColumns;
}

#pragma mark Header Cell

- (UIView *)tableView:(EWMultiColumnTableView *)tableView headerCellForIndexPath:(NSIndexPath *)indexPath
{
    return [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 200.0f, 40.0f)] autorelease];
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForHeaderCell:(UIView *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UILabel *l = (UILabel *)cell;
    NSString *cellTitle = [[[self.columnNamesPerRow objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:0];
    BOOL is_highlighted = [[[[self.columnNamesPerRow objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectAtIndex:1] boolValue];

    l.text = cellTitle;
    l.font = [UIFont systemFontOfSize:13.0];
    if (is_highlighted) {
        l.textColor = [UIColor blueColor];
    }
    l.backgroundColor = [UIColor colorWithWhite:249.0f/255.0f alpha:1.0f];
    [l sizeToFit];
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForHeaderCellAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (CGFloat)tableView:(EWMultiColumnTableView *)tableView heightForSectionHeaderCellAtSection:(NSInteger)section column:(NSInteger)col
{
    return 0.0f;
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView headerCellInSectionHeaderForSection:(NSInteger)section
{
    UILabel *l = [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, [self widthForHeaderCellOfTableView:tableView], 0.0f)] autorelease];
    l.backgroundColor = [UIColor orangeColor];
    return l;
    
}

- (void)tableView:(EWMultiColumnTableView *)tableView setContentForHeaderCellInSectionHeader:(UIView *)cell AtSection:(NSInteger)section
{
    UILabel *l = (UILabel *)cell;
    l.text = [NSString stringWithFormat:@"Section %d", section];
}

- (CGFloat)widthForHeaderCellOfTableView:(EWMultiColumnTableView *)tableView
{
    return 250.0f;
}

- (UIView *)tableView:(EWMultiColumnTableView *)tableView headerCellForColumn:(NSInteger)col
{
    UILabel *l =  [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 240.0f, 50.0f)] autorelease];
    l.text = [self.myheaders objectAtIndex:col];
    l.font = [UIFont boldSystemFontOfSize:16];
    l.backgroundColor = [UIColor colorWithWhite:249.0f/255.0f alpha:1.0f];
    l.userInteractionEnabled = YES;    
    l.tag = col;
    
    return l;
}

- (UIView *)topleftHeaderCellOfTableView:(EWMultiColumnTableView *)tableView
{
    UILabel *l =  [[[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, 240.0f, [self heightForHeaderCellOfTableView:tableView])] autorelease];
    l.text = self.specification.specificationType.name;
    l.font = [UIFont boldSystemFontOfSize:16];
    l.backgroundColor = [UIColor colorWithWhite:249.0f/255.0f alpha:1.0f];

    return l;
}

- (CGFloat)heightForHeaderCellOfTableView:(EWMultiColumnTableView *)tableView
{
    return 50.0f;
}

- (void)tableView:(EWMultiColumnTableView *)tableView swapDataOfColumn:(NSInteger)col1 andColumn:(NSInteger)col2
{
    for (int i = 0; i < [self numberOfSectionsInTableView:tableView]; i++) {
        NSMutableArray *section = [data objectAtIndex:i];
        for (int j = 0; j < [self tableView:tableView numberOfRowsInSection:i]; j++) {
            NSMutableArray *a = [section objectAtIndex:j];
            id tmp = [[a objectAtIndex:col2] retain];
            
            [a replaceObjectAtIndex:col2 withObject:[a objectAtIndex:col1]];
            [a replaceObjectAtIndex:col1 withObject:tmp];
            [tmp release];
        }
    }
}

@end
