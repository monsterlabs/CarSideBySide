//
//  CoreDataSeed.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "CoreDataSeed.h"
#import "AppDelegate.h"
#import "NSManagedObject+Find.h"
#import "Offer.h"
#import "Brand.h"

@implementation CoreDataSeed
@synthesize managedObjectContext;

-(id)init
{
    self.managedObjectContext = [appDelegate managedObjectContext];
    return self;
}

-(void)loadInitialData
{
    [self insertOffers];
    [self insertBrands];
}

# pragma - Database population
-(void)insertOffers {
    if ([[Offer findAll] count] == 0 ) {
        NSLog(@"Inserting data into the Offer model..");
        NSArray *offers = [ NSArray arrayWithObjects:
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 528i Sedan Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_1.jpg", @"image",
                            @"bmw_offer_test_1_large.jpg", @"largeImage",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-12-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 628i Coupe Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_2.jpg", @"image",
                            @"bmw_offer_test_2_large.jpg", @"largeImage",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-11-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 728i Convertible Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_3.jpg", @"image",
                            @"bmw_offer_test_3_large.jpg", @"largeImage",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-10-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 328i Sedan Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_1.jpg", @"image",
                            @"bmw_offer_test_1_large.jpg", @"largeImage",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-09-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 128i Gran Turismo Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_2.jpg", @"image",
                            @"bmw_offer_test_2_large.jpg", @"largeImage",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-08-29", @"validUntil",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Current 7s28i Active E Special Offers", @"title",
                            @"Qualified customers only. Available at participating BMW centers through BMW Financial Services NA, LLC. Applies only to specific models and only for specific model years. 3.05% APR for 36 months available through May 31, 2013. $29.10 per $1,000. ", @"body",
                            @"bmw_offer_test_3.jpg", @"image",
                            @"bmw_offer_test_3_large.jpg", @"largeImage",
                            @"http://bit.ly/146ObXC", @"url",
                            @"2013-07-29", @"validUntil",
                            nil],
                           nil];
        
        for (NSDictionary *dict in offers) {
            Offer *offer = [CoreDataSeed offerFromDictionary:dict];
            [self saveContext];
        }
        
    }
}

-(void)insertBrands {
    if ([[Brand findAll] count] == 0) {
        NSLog(@"Inserting data into the Brand model..");
        NSArray *brands = [NSArray arrayWithObjects:@"BMW", @"Audi", @"Volvo", @"Mercedes Benz", nil];
        for (NSString *brandName in brands ) {
            Brand *brand = [CoreDataSeed brandFromString:brandName];
            [self saveContext];
        }
    }
}

-(void)saveContext
{
    NSError *error;
    [[appDelegate managedObjectContext] save:&error];
    if (error != nil)
        NSLog(@"Managed Object Context has the following error: %@", error);
    else
        NSLog(@"Managed Object Context saved...");
}

# pragma - Methods to create new records
+(Offer *)offerFromDictionary:(NSDictionary *)dict;
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-mm-dd"];
    
    Offer *offer = (Offer *)[NSEntityDescription insertNewObjectForEntityForName:@"Offer" inManagedObjectContext:[appDelegate managedObjectContext]];
    [offer setTitle: [dict valueForKey:@"title"]];
    [offer setBody: [dict valueForKey:@"body"]];
    [offer setImage: [dict valueForKey:@"image"]];
    [offer setLargeImage: [dict valueForKey:@"largeImage"]];
    [offer setUrl: [dict valueForKey:@"url"]];
    [offer setEnabled: YES];
    [offer setValidUntil: [dateFormatter dateFromString: [dict valueForKey:@"validUntil"]]];
    
    return  offer;
}

+(Brand *)brandFromString:(NSString *)name
{
    Brand *brand = (Brand *)[NSEntityDescription insertNewObjectForEntityForName:@"brand" inManagedObjectContext:[appDelegate managedObjectContext]];
    [brand setName:name];
    return brand;
}


@end
