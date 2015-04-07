//
//  DRYParameterProviderParametersTests.m
//  DRYTestUtilities
//
//  Created by Michael Seghers on 08/04/15.
//  Copyright (c) 2015 Michael Seghers. All rights reserved.
//

#import "DRYParameterizedTestCase.h"
#import "DRYSimpleTestNameProvidingParameter.h"

@interface NSString (TestNameProvider) <TestNameProvider>
@end

@implementation NSString (TestNameProvider)

- (NSString *)testName {
    return [self stringByAppendingString:@"_test"];
}
@end

@interface NSNumber (ParameterProvider) <ParameterProvider>
@end

@implementation NSNumber (ParameterProvider)

- (id)parameter {
    return self.stringValue;
}

@end

@interface DRYParameterProviderParametersTests : DRYParameterizedTestCase

@end

@implementation DRYParameterProviderParametersTests

+(NSArray *)parameters {
    return @[
             [DRYSimpleTestNameProvidingParameter parameterWithTestName:@"isFour4Long" parameter:@"four"],
             @"five",
             @1234
             ];
}

-(void)testWithParameter:(NSString *)parameter {
    XCTAssertEqual(parameter.length, 4);
}
@end
