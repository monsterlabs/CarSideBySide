//
//  ComparedFeature.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comparative, Feature;

@interface ComparedFeature : NSManagedObject

@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Feature *feature;
@property (nonatomic, retain) Comparative *comparative;

@end
