//
//  ProductsViewController.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductsViewInput.h"

@protocol ProductsViewOutput;

@interface ProductsViewController : UICollectionViewController <ProductsViewInput>{
    
}

@property (nonatomic, strong) id<ProductsViewOutput> output;

@end

