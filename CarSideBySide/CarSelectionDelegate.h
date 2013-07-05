//
//  CarSelectionDelegate.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/4/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Car;

@protocol CarSelectionDelegate <NSObject>

@required
-(void)selectedCar:(Car *)newCar;
@end
