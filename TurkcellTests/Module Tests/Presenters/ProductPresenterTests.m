//
//  ProductPresenterTests.m
//  TurkcellTests
//
//  Created by Alaattin Bedir on 20.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductPresenter.h"

@interface ProductPresenterTests : XCTestCase

@property (nonatomic) ProductPresenter *vcToTest;

@end

@implementation ProductPresenterTests

- (void)setUp {
    [super setUp];
    
    self.vcToTest = [[ProductPresenter alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testDidTriggerViewReadyEvent {
    [self.vcToTest didTriggerViewReadyEvent];
}

- (void) testSetViewForSetup {
    // 1. given
    UIView *testView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 2. when
    [self.vcToTest setViewForSetup:testView];
    
    // 3. then
    XCTAssertEqual(testView, testView, "Same view");
}

- (void) testSetData {
    // 1. given
    NSArray *products = [[NSArray alloc] initWithObjects:@"Apple",@"Orange", nil];
    
    // 2. when
    [self.vcToTest setData:products];
    
    // 3. then
    XCTAssertEqual(products.count, products.count, "Same count");
}



@end
