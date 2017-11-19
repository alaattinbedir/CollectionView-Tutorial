//
//  ProductsViewOutput.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Product.h"

@protocol ProductsViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;
- (void)setViewForSetup:(UIView *)view;
- (void)setData:(Product *)product;

@end
