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
#import "AppDelegate.h"
#import <AFImageDownloader.h>
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
    modelLabel.text = self.car.modelName;
    self.navBarItem.title = self.car.modelName;
    
    highlighsTextView.text = self.car.highlights;
    highlighsTextView.font = [UIFont systemFontOfSize:14.0f];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[self.car valueForKey:@"image"]];
    
    if(![fileManager fileExistsAtPath:imagePath])
    {
        NSString *dummyImagePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"../CarSideBySide.app/car_dummy.jpg"];
        NSData *data = [NSData dataWithContentsOfFile:dummyImagePath];
        carImageView.image = [UIImage imageWithData:data];
        
        NetworkReachability *networkReachability = [appDelegate networkReachability];
        if ([networkReachability isReachable])
        {
            [UIApplication sharedApplication].networkActivityIndicatorVisible =  YES;
            [AFImageDownloader imageDownloaderWithURLString:[self.car valueForKey:@"imageUrl"] autoStart:YES completion:^(UIImage *decompressedImage) {
                NSData *binaryImage = UIImageJPEGRepresentation(decompressedImage, 0.8);
                [binaryImage writeToFile:imagePath atomically:YES];
                carImageView.image = decompressedImage;
                [UIApplication sharedApplication].networkActivityIndicatorVisible =  NO;
            }];
        }
    } else {
        NSData *data = [NSData dataWithContentsOfFile:imagePath];
        carImageView.image = [UIImage imageWithData:data];
    }

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
    if (self.car == nil) {
        highlighsTextView.text = @"Selecciona una serie y un modelo...";
        highlighsTextView.font = [UIFont systemFontOfSize:32.0f];
        [self.toolbar setHidden:YES];
    }
    [self resizeItemsForInterfaceOrientation];
    [super viewDidAppear:TRUE];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:TRUE];
}

- (void)viewDidLayoutSubviews
{
    [self resizeItemsForInterfaceOrientation];
    [super viewDidLayoutSubviews];
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

- (void)resizeItemsForInterfaceOrientation
{
    BOOL isLandscape = UIDeviceOrientationIsLandscape(self.interfaceOrientation);
    if (isLandscape) {
        [self resizeCarImageView];
        [highlighsTextView setFrame:CGRectMake(10, 510, 680, 152)];
        [self.toolbar setFrame:CGRectMake(0, 660, 768, 44)];
    } else {
        [self.toolbar setFrame:CGRectMake(0, 915, 768, 44)];
        [highlighsTextView setFrame:CGRectMake(20, 510, 728, 400)];
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
    barButtonItem.title = NSLocalizedString(@"Menú", nil);
    barButtonItem.style = UIBarButtonItemStyleDone;
    [_navBarItem setLeftBarButtonItem:barButtonItem animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    self.segueIdentifier = button.title;
    self.popoverSegue = (id)segue;
    ComparativeViewController *comparativeViewController = segue.destinationViewController;
    comparativeViewController.specification = [self.car specificationBySpecificationTypeName:button.title];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    [self.popoverSegue.popoverController dismissPopoverAnimated:YES];
    if ([self.segueIdentifier isEqualToString:self.prevSegueIdentifier]) {
        self.prevSegueIdentifier = @"";
        return NO;
    } else {
        self.prevSegueIdentifier = self.segueIdentifier;
        return YES;
    }
}

@end
