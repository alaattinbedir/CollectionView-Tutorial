//
//  ProductMO.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface ProductMO : NSManagedObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSData *image;
@property (nonatomic, strong) NSString *desc;

@end
