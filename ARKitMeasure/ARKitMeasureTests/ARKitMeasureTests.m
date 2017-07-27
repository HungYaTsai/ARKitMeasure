//
//  ARKitMeasureTests.m
//  ARKitMeasureTests
//
//  Created by 蔡弘亞 on 26/07/2017.
//  Copyright © 2017 蔡弘亞. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ARKitMeasureTests : XCTestCase

@end

@implementation ARKitMeasureTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
