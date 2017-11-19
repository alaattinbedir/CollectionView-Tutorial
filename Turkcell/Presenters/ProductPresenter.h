//
//  ProductPresenter.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductInteractorOutput.h"
#import "ProductsViewInput.h"
#import "ProductsViewOutput.h"

@protocol ProductInteractorInput;
@protocol ProductsViewInput;

@interface ProductPresenter : NSObject <ProductsViewInput, ProductsViewOutput,ProductInteractorOutput>

@property (nonatomic, strong) id<ProductsViewInput> view;
@property (nonatomic, strong) id<ProductInteractorInput> interactor;



@end
