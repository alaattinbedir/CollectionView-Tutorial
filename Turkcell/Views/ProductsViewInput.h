//
//  ProductsViewInput.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ProductsViewInput <NSObject>
- (void)setupInitialState;
- (void)setData:(NSArray *)products;

@end
