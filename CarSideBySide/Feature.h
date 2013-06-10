//
//  Feature.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/10/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comparative, Specification;

@interface Feature : NSManagedObject

@property (nonatomic, retain) NSString * additionalInfo;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *comparatives;
@property (nonatomic, retain) Specification *specification;
@end

@interface Feature (CoreDataGeneratedAccessors)

- (void)addComparativesObject:(Comparative *)value;
- (void)removeComparativesObject:(Comparative *)value;
- (void)addComparatives:(NSSet *)values;
- (void)removeComparatives:(NSSet *)values;

@end
