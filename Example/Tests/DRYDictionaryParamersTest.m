//
//  DRYDictionaryParamersTest.m
//  DRYTestUtilities
//
//  Created by Michael Seghers on 08/04/15.
//  Copyright (c) 2015 Michael Seghers. All rights reserved.
//

#import "DRYParameterizedTestCase.h"

@interface DRYDictionaryParamersTest : DRYParameterizedTestCase {
    NSNumberFormatter *_formatter;
}

@end

@implementation DRYDictionaryParamersTest

+(NSArray *)parameters {
    return @[
             @{@"number": @1, @"string": @"one", @"testName": @"oneToOne"},
             @{@"number": @2, @"string": @"two"}];
}


- (void)setUp {
    [super setUp];
    _formatter = [[NSNumberFormatter alloc] init];
    _formatter.numberStyle = NSNumberFormatterSpellOutStyle;
    _formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_UK"];
}

- (void)testWithParameter:(NSDictionary *)parameter {
    XCTAssertEqualObjects([_formatter stringFromNumber:parameter[@"number"]], parameter[@"string"]);
}


@end
