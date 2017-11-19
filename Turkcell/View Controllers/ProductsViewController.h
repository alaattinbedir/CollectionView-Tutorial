//
//  ProductsViewController.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsViewInput.h"
#import "ProductsViewOutput.h"
#import "ProductInteractorInput.h"

@protocol ProductsViewOutput;

@interface ProductsViewController : UICollectionViewController <ProductsViewInput,ProductsViewOutput>{
    
}

@property (nonatomic, strong) id<ProductsViewOutput> output;
@property (nonatomic, strong) id<ProductInteractorInput> interactor;
@property (nonatomic, strong) NSArray *products;

@end

