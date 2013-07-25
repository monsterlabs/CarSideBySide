//
//  Serie.h
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/13/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand, Line;

@interface Serie : NSManagedObject

@property (nonatomic, retain) NSNumber * enabled;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) NSSet *lines;
@end

@interface Serie (CoreDataGeneratedAccessors)

- (void)addLinesObject:(Line *)value;
- (void)removeLinesObject:(Line *)value;
- (void)addLines:(NSSet *)values;
- (void)removeLines:(NSSet *)values;
- (void)setSerieFromDictionary:(NSDictionary*)dict;


@end
