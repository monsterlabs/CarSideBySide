//
//  Feature.h
//  CarSideBySide
//
//  Created by Alejandro Juarez Robles on 7/2/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComparedFeature, Specification;

@interface Feature : NSManagedObject

@property (nonatomic, retain) NSString * additionalInfo;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * highlighted;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * sequence;
@property (nonatomic, retain) Specification *specification;
@property (nonatomic, retain) NSSet *comparedFeatures;
@end

@interface Feature (CoreDataGeneratedAccessors)

- (void)addComparedFeaturesObject:(ComparedFeature *)value;
- (void)removeComparedFeaturesObject:(ComparedFeature *)value;
- (void)addComparedFeatures:(NSSet *)values;
- (void)removeComparedFeatures:(NSSet *)values;
- (NSString *) nameORAdditionalInfo;

@end
