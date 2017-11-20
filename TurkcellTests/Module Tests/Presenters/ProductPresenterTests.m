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

@end
