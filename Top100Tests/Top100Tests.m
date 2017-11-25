//
//  Top100Tests.m
//  Top100Tests
//
//  Created by Jitesh Middha on 21/11/17.
//  Copyright © 2017 Jitesh Middha. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs.h>
#import <OHPathHelpers.h>
#import "GetListFromAPI.h"

@interface Top100Tests : XCTestCase

@end

@implementation Top100Tests

- (void)setUp {
    [super setUp];
   
}



- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Query timed out."];
    
    GetListFromAPI *getOperation = [[GetListFromAPI alloc] initWithCompletion:^(Feed *feed, NSError *error) {

        //check if error is nil
        XCTAssertNil(error);
        
        // checking list contains data
        XCTAssertTrue(feed.songsList.count > 0);
        
        // checking if value exists
        XCTAssertTrue([[feed.songsList objectAtIndex:0] valueForKey:@"artistName"]);
        XCTAssertTrue([[feed.songsList objectAtIndex:0] valueForKey:@"genres"]);
        XCTAssertTrue([[feed.songsList objectAtIndex:0] valueForKey:@"artworkUrl"]);
        
        [expectation fulfill];
    }];
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue addOperation:getOperation];

    [queue waitUntilAllOperationsAreFinished];
//
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
