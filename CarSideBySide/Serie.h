//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand, CarModel;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * portraitImage;
@property (nonatomic, retain) NSString * landscapeImage;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) NSSet *carModels;
@end

@interface Serie (CoreDataGeneratedAccessors)

- (void)addCarModelsObject:(CarModel *)value;
- (void)removeCarModelsObject:(CarModel *)value;
- (void)addCarModels:(NSSet *)values;
- (void)removeCarModels:(NSSet *)values;

@end
