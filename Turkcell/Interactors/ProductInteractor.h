//
//  ProductInteractor.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInteractorInput.h"
#import "ProductInteractorOutput.h"

@protocol ProductInteractorOutput;
@interface ProductInteractor : NSObject 

@property (nonatomic, strong)   NSMutableArray  *products;
@property (nonatomic, weak) id<ProductInteractorOutput> output;

- (void) requestProduct;

@end
