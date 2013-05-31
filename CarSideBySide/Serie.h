//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 5/31/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Line, Maker;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Maker *maker;
@property (nonatomic, retain) NSSet *lines;
@end

@interface Serie (CoreDataGeneratedAccessors)

- (void)addLinesObject:(Line *)value;
- (void)removeLinesObject:(Line *)value;
- (void)addLines:(NSSet *)values;
- (void)removeLines:(NSSet *)values;

@end
