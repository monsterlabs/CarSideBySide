//
//  SpecificationType.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Specification;

@interface SpecificationType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *specifications;
@end

@interface SpecificationType (CoreDataGeneratedAccessors)

- (void)addSpecificationsObject:(Specification *)value;
- (void)removeSpecificationsObject:(Specification *)value;
- (void)addSpecifications:(NSSet *)values;
- (void)removeSpecifications:(NSSet *)values;

@end
