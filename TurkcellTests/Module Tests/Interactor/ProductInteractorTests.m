//
//  ProductInteractorTests.m
//  TurkcellTests
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductInteractor.h"

@interface ProductInteractorTests : XCTestCase

@property (nonatomic) ProductInteractor *vcToTest;

@end

@implementation ProductInteractorTests

- (void)setUp {
    [super setUp];
    
    self.vcToTest = [[ProductInteractor alloc] init];
}

- (void) testRequestProduct {
    [self.vcToTest requestProduct];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

@end
