//
//  DRYNoParametersParameteridTests.m
//  DRYTestUtilities
//
//  Created by Michael Seghers on 26/07/16.
//  Copyright © 2016 Michael Seghers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <DRYTestUtilities/DRYParameterizedTestCase.h>

@interface DRYActualNoParametersTests : XCTestCase

@end


@interface DRYNoParametersParameteridTests : DRYParameterizedTestCase

@end

@implementation DRYNoParametersParameteridTests

- (void)setUp {
    [super setUp];
}

- (void)testShouldHaveAnInvocation {
    
}

@end


@interface DRYZeroParametersParameteridTests : DRYParameterizedTestCase

@end

@implementation DRYZeroParametersParameteridTests

+(NSArray *)parameters {
    return @[];
}

- (void)setUp {
    [super setUp];
}

- (void)testShouldHaveAnInvocation {
    
}

@end

@interface DRYNilParametersParameteridTests : DRYParameterizedTestCase

@end

@implementation DRYNilParametersParameteridTests

+(NSArray *)parameters {
    return nil;
}

- (void)setUp {
    [super setUp];
}

- (void)testShouldHaveAnInvocation {
    
}

@end

@implementation DRYActualNoParametersTests

- (void)testShouldHaveAnInvocationWhenNoParametersMethodIsAvailable {
    NSArray *testCaseInvocation = [DRYNoParametersParameteridTests testInvocations];
    XCTAssertEqual(testCaseInvocation.count, 1);
}

- (void)testShouldHaveAnInvocationWhenParametersAreNil {
    NSArray *testCaseInvocation = [DRYNilParametersParameteridTests testInvocations];
    XCTAssertEqual(testCaseInvocation.count, 1);
}

- (void)testShouldHaveAnInvocationWhenParametersIsEmptyArray {
    NSArray *testCaseInvocation = [DRYZeroParametersParameteridTests testInvocations];
    XCTAssertEqual(testCaseInvocation.count, 1);
}




@end
