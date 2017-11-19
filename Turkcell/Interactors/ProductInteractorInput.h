//
//  ProductInteractorInput.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ProductInteractorInput <NSObject>
- (void)requestProduct;
- (void)setViewForSetup:(UIView *)view;

@end
