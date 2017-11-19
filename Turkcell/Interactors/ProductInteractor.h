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
#import "ProductsViewOutput.h"

@protocol ProductInteractorOutput;
@interface ProductInteractor : NSObject <ProductInteractorInput>

@property (nonatomic, strong)   NSMutableArray  *products;
@property (nonatomic, weak) id<ProductInteractorOutput> output;
@property (nonatomic, strong) id<ProductsViewOutput> view;


@end
