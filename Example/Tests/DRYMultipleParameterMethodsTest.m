//
//  DRYMultipleParameterMethodsTest.m
//  DRYTestUtilities
//
//  Created by Michael Seghers on 08/06/16.
//  Copyright © 2016 Michael Seghers. All rights reserved.
//

#import "DRYParameterizedTestCase.h"

@interface DRYMultipleParameterMethodsTest : DRYParameterizedTestCase

@end

@implementation DRYMultipleParameterMethodsTest

+ (NSArray *)parameters {
    return @[@1, @2, @3];
}

- (void)testWithParameterForX:(NSNumber *)parameter {
    XCTAssertLessThan(parameter.integerValue, 4);
}

- (void)testWithParameterForY:(NSNumber *)parameter {
    XCTAssertLessThan(parameter.integerValue, 4);
}

@end
