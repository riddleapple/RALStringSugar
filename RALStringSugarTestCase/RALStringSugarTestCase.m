//
//  RALStringSugarTestCase.m
//  RALStringSugarTestCase
//
//  Created by Riddle Ling on 2015/5/13.
//  Copyright (c) 2015年 Riddle Ling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>

#import "NSString+RALStringSugar.h"



@interface RALStringSugarTestCase : XCTestCase

@end


@implementation RALStringSugarTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testStrip {
    XCTAssertEqualObjects([@"  123 " strip], @"123");
}

- (void)testTrimmingChars {
    XCTAssertEqualObjects([@"ab 123 ba" trimmingChars:@"ab "], @"123");
}

- (void)testSplit {
    NSArray *array =[@"1, 2, 3" split:@", "];
    BOOL isEqual = [array isEqualToArray:@[@"1", @"2", @"3"]];
    XCTAssertEqual(isEqual, YES);
}

- (void)testIsInclude {
    BOOL isInclude = [@"python, ruby, swift" isInclude:@"ruby"];
    XCTAssertEqual(isInclude, YES);
}

- (void)testIsEmpty {
    BOOL isEmpty = [@"" isEmpty];
    XCTAssertEqual(isEmpty, YES);
}

- (void)testGsub {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"[aeiou]"
                                  options:0
                                  error:nil];
    
    NSString *str =[@"hello" gsub:regex replacement:@"*"];
    XCTAssertEqualObjects(str, @"h*ll*");
}

- (void)testGsubWithBlock {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"."
                                  options:0
                                  error:nil];
    
    NSString *str = [@"hello" gsub:regex block:^(NSString *match){ return [match uppercaseString]; }];
    
    XCTAssertEqualObjects(str, @"HELLO");
}

- (void)testMatch {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"(.)\\1"
                                  options:0
                                  error:nil];
    
    NSString *firstMatchStr = [@"hello" match:regex block:^(NSString *match){ return match; }];
    
    XCTAssertEqualObjects(firstMatchStr, @"ll");
}

- (void)testScan {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\w+"
                                  options:0
                                  error:nil];
    
    NSArray *array = [@"cruel world" scan:regex];
    BOOL isEqual = [array isEqualToArray:@[@[@"cruel"], @[@"world"]]];
    
    XCTAssertEqual(isEqual, YES);
}

- (void)testScanWithBlock {
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:@"\\w+"
                                  options:0
                                  error:nil];
    
    NSMutableArray *array = [NSMutableArray array];
    [@"cruel world" scan:regex block:^(RALMatchResult* matchResult){
        [array addObject:matchResult.group];
    }];
    
    BOOL isEqual = [array isEqualToArray:@[@[@"cruel"], @[@"world"]]];
    
    XCTAssertEqual(isEqual, YES);
}

@end
