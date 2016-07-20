//
//  DRYRuleBasedSimpleRuleTests.m
//  DRYTestUtilities
//
//  Created by Michael Seghers on 01/07/16.
//  Copyright © 2016 Michael Seghers. All rights reserved.
//

#import "DRYRuleBasedTestCase.h"
#import "DRYTestRule.h"
#import "DRYOCMockitoTestRule.h"
#import "OCMockito.h"

@interface SimpleRule : NSObject<DRYTestRule>

@property (nonatomic, strong, readonly) NSString *beforeVal;
@property (nonatomic, strong, readonly) NSString *afterVal;

- (instancetype)initWithValueSetBeforeTest:(NSString *)beforeVal andValueSetAfterTest:(NSString *)afterVal;

@end

@interface CanIBeInjectedWithMocksHelper : NSObject

@property (nonatomic, strong) NSObject *fakeObject;

@end

@interface DRYRuleBasedSimpleRuleTests : DRYRuleBasedTestCase

@property (nonatomic, strong) NSObject<UITableViewDelegate> *mockedTableViewDelegateAsObject;
@property (nonatomic, strong) id<UITableViewDelegate> mockedTableViewDelegate;
@property (nonatomic, strong) NSObject *mockSomeObject;
@property (nonatomic, strong) CanIBeInjectedWithMocksHelper *helper;
@property (nonatomic, strong) NSObject *fakeObject;

@property (nonatomic, strong) SimpleRule *rule;
@property (nonatomic, strong) DRYOCMockitoTestRule *mockitoRule;

@end

@implementation DRYRuleBasedSimpleRuleTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    XCTAssertEqual(_rule.beforeVal, @"before");
}

- (NSArray *)testRules {
    self.rule = [[SimpleRule alloc] initWithValueSetBeforeTest:@"before" andValueSetAfterTest:@"after"];
    self.mockitoRule = [DRYOCMockitoTestRule mockitoTestRule];
    
    return @[_rule, _mockitoRule, [DRYOCMockitoTestRule mockitoTestRultWithMockedPropertyPrefix:@"fake"]];
}

- (void)testMocksAreInjected {
    XCTAssertNotNil(self.mockedTableViewDelegate);
    XCTAssertNotNil(self.mockedTableViewDelegateAsObject);
    XCTAssertNotNil(self.mockSomeObject);
}

- (void)testRuleDoesNotInjectNonPrefixedStuff {
    XCTAssertNil(self.helper);
}

- (void)testRuleSucceededInInjectingView {
    self.helper = [[CanIBeInjectedWithMocksHelper alloc] init];
    [_mockitoRule injectMocksIntoPropertiesWithPrefix:@"fake" ofObject:self.helper];
    XCTAssertNotNil(self.helper.fakeObject);
    XCTAssertEqual([MKTObjectMock class], [self.helper.fakeObject class]);
}

- (void)testRuleSucceededInInjectingFakePrefixedProperties {
    XCTAssertNotNil(self.fakeObject);
}

@end

@implementation SimpleRule {
    NSString *_valueToSetOnBefore;
    NSString *_valueToSetOnAfter;
}

- (instancetype)initWithValueSetBeforeTest:(NSString *)beforeVal andValueSetAfterTest:(NSString *)afterVal
{
    self = [super init];
    if (self) {
        _valueToSetOnBefore = beforeVal;
        _valueToSetOnAfter = afterVal;
    }
    return self;
}

- (void)before {
    _beforeVal = _valueToSetOnBefore;
}

- (NSInvocation *)apply:(NSInvocation *)invocation {
    return invocation;
}

- (void)after {
    _afterVal = _valueToSetOnAfter;
}


@end

@implementation CanIBeInjectedWithMocksHelper
@end
