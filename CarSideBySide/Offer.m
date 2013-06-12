//
//  Offer.m
//  CarSideBySide
//
//  Created by Alejandro Juarez on 6/11/13.
//  Copyright (c) 2013 Alejandro Juarez Robles. All rights reserved.
//

#import "Offer.h"
#import "NSManagedObject+Util.h"

@implementation Offer

@dynamic body;
@dynamic enabled;
@dynamic image;
@dynamic largeImage;
@dynamic title;
@dynamic url;
@dynamic validUntil;

- (void)setOfferFromDictionary:(NSDictionary*)dict
{
    self.title = [dict valueForKey:@"title"];
    self.body = [dict valueForKey:@"body"];
    self.image = [dict valueForKey:@"image"];
    self.largeImage = [dict valueForKey:@"largeImage"];
    self.url = [dict valueForKey:@"url"];
    self.enabled = [Offer boolFromString:[dict valueForKey:@"enabled"]];
    self.validUntil = [Offer dateFromString: [dict valueForKey:@"validUntil"]];
}
@end
