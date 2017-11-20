//
//  Product.m
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize productId;
@synthesize name;
@synthesize price;
@synthesize image;
@synthesize desc;

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
    id obj = [[Product alloc] initWithDictionary:dictionary];
    return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self=[super init];
    if(self)
    {
        productId = [dictionary objectForKey:@"product_id"];
        name = [dictionary objectForKey:@"name"];
        price = [[dictionary objectForKey:@"price"] longValue];
        image = [dictionary objectForKey:@"image"];
    }
    return self;
}

+ (NSMutableArray*) arrayWithDictionary:(NSDictionary*)dictionary{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *products = [dictionary objectForKey:@"products"];
    if(products != nil && ![products isKindOfClass:[NSNull class]]) {
        for(NSDictionary *product in products) {
            [result addObject:[Product objectWithDictionary:product]];
        }
    }
    
    return result;
}

@end
