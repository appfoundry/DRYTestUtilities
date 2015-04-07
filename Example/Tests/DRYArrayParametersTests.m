//
//  DRYArrayParametersTests.m
//  DRYTestUtilities
//
//  Created by Michael Seghers on 08/04/15.
//  Copyright (c) 2015 Michael Seghers. All rights reserved.
//

#import "DRYParameterizedTestCase.h"

@interface DRYArrayParametersTests : DRYParameterizedTestCase

@end

@implementation DRYArrayParametersTests

+ (NSArray *)parameters {
    return @[
        @[@1, @2],
        @[@2, @3]
    ];
}

- (void)setUp {
    [super setUp];
}

- (void)testWithParameter:(NSArray *)parameter {
    XCTAssertLessThan([parameter.firstObject integerValue], [parameter.lastObject integerValue]);
}

@end
