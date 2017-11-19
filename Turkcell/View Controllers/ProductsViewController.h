//
//  ViewController.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInteractorOutput.h"
#import "ProductsViewInput.h"

@protocol ProductsViewOutput;
@protocol ProductInteractorOutput;

@interface ProductsViewController : UICollectionViewController <ProductInteractorOutput,ProductsViewInput>{
    
}

@property (nonatomic, strong) id<ProductsViewOutput> output;
@property (nonatomic, strong) id<ProductInteractorOutput> interactor; 

@end

