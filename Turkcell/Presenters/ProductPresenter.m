//
//  ProductPresenter.m
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "ProductPresenter.h"
#import "ProductsViewInput.h"
#import "ProductInteractorInput.h"

@implementation ProductPresenter {
    NSArray *products;
}

#pragma mark - Method MoviesListViewInput
- (void)setupInitialState{
    
}

#pragma mark - Method MoviesListViewOutput
- (void)didTriggerViewReadyEvent {
    [self.view setupInitialState];
}

- (void)setViewForSetup:(UIView *)view {
    [self.interactor setViewForSetup:view];
}

- (void)setData:(Product *)product {
    products= [NSArray arrayWithObject:product];
    [self.interactor setData:products];
}


@end
