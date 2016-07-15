//
//  DRYRuleBasedTestCase.m
//  Pods
//
//  Created by Michael Seghers on 01/07/16.
//
//

#import "DRYRuleBasedTestCase.h"
#import "DRYTestRule.h"

@interface DRYRuleBasedTestCase () {
    NSArray *_testRules;
}

@end

@implementation DRYRuleBasedTestCase

- (instancetype)initWithInvocation:(NSInvocation *)invocation {
    self = [super initWithInvocation:invocation];
    if (self) {
        _testRules = [self testRules];
    }
    return self;
}

- (void)invokeTest {
    for (id<DRYTestRule> rule in _testRules) {
        [rule before];
    }
    self.invocation = [self _applyRules:self.invocation];
    [super invokeTest];
    for (id<DRYTestRule> rule in [_testRules reverseObjectEnumerator]) {
        [rule after];
    }
}

- (NSInvocation *)_applyRules:(NSInvocation *)invocation {
    NSInvocation *result = invocation;
    for (id<DRYTestRule> rule in _testRules) {
        result = [rule apply:result];
    }
    return result;
}

- (NSArray *)testRules {
    return nil;
}

@end
