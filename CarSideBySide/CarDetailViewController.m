//
//  CarDetailViewController.m
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/3/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CarDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Car.h"
#import "ComparativeViewController.h"
@interface CarDetailViewController ()

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *buttonItem;
@property (strong, nonatomic) NSString *segueIdentifier;
@property (strong, nonatomic) NSString *prevSegueIdentifier;
@property (strong, nonatomic) UIStoryboardPopoverSegue *popoverSegue;

@end

@implementation CarDetailViewController
@synthesize segueIdentifier, prevSegueIdentifier, popoverSegue;

-(void)setCar:(Car *)newCar
{
    if (_car != newCar) {
        _car = newCar;
    }
    [self configureView];
    self.prevSegueIdentifier = @"";
}

- (void)configureView
{
    modelLabel.text = self.car.model;
    self.navBarItem.title = self.car.model;
    
    highlighsTextView.text = self.car.highlights;
    
    
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[self.car valueForKey:@"image"]];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];

    carImageView.image = [UIImage imageWithData:data];

    carImageView.layer.cornerRadius = 3.0f;
    carImageView.layer.masksToBounds = YES;
    carImageView.layer.borderColor = [UIColor underPageBackgroundColor].CGColor;
    carImageView.layer.borderWidth = 1.0;
    carImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    carImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.toolbar setHidden:NO];
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        [self resizeCarImageView];
        [carImageView setNeedsDisplay];
                [self.view setNeedsDisplay];
    }
        
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    navController  = [[UINavigationController alloc] initWithRootViewController:self];

    if (self) {        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.car != nil) {
        [self configureView];
    } 
}

- (void)viewDidAppear:(BOOL)animated
{
    BOOL isLandscape = UIDeviceOrientationIsLandscape(self.interfaceOrientation);
    if (isLandscape) {
        [self resizeCarImageView];
    }
    if (self.car == nil) {
        highlighsTextView.text = @"";
        [self.toolbar setHidden:YES];
    }
    [super viewDidAppear:TRUE];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (fromInterfaceOrientation == 1 || fromInterfaceOrientation == 2)
    {
        [self resizeCarImageView];
        [self.navBarItem setLeftBarButtonItem:nil animated:YES];
    }
}

- (void)resizeCarImageView
{
    CGSize imageSize = carImageView.image.size;
    CGPoint newCenter = {354.000000, carImageView.center.y};
    CGRect rect = CGRectMake(0, 0, imageSize.width - 65, imageSize.height - 50);
    carImageView.frame = rect;
    carImageView.center = newCenter;
}

# pragma mark - Car Selection Delegate
- (void)selectedCar:(Car *)newCar
{
    [self setCar:newCar];
    
    if (_popover != nil) {
      [_popover dismissPopoverAnimated:YES];
    }
}

# pragma mark - UISplitViewDelegate methods
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{

    self.popover = pc;
    
    barButtonItem.title = @"Select";
    
    [_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    self.segueIdentifier = button.title;
    self.popoverSegue = (id)segue;
    ComparativeViewController *comparativeViewController = segue.destinationViewController;
    comparativeViewController.specification = [self.car specificationBySpecificationTypeName:button.title];
    self.prevSegueIdentifier = self.segueIdentifier;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([self.segueIdentifier isEqualToString:self.prevSegueIdentifier]) {
        [self.popoverSegue.popoverController dismissPopoverAnimated:YES];
        prevSegueIdentifier = @"";
        return NO;
    }
    else
        return YES;
}

@end
