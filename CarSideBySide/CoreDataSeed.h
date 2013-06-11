//
//  CoreDataSeed.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataSeed : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

-(id)init;
-(void)loadInitialData;
@end

