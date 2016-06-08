//
//  DRYParameterizedTestCase.m
//  Pods
//
//  Created by Michael Seghers on 08/04/15.
//
//

#import <objc/runtime.h>
#import "DRYParameterizedTestCase.h"


@implementation DRYParameterizedTestCase

+ (NSArray *)testInvocations {
    if (self == [DRYParameterizedTestCase class]) {
        return nil;
    }
    
    SEL parameterSel = @selector(parameters);
    if (![self respondsToSelector:parameterSel]) {
        return nil;
    }
    
    
    NSArray *params = [self parameters];
    
    
    
    NSMutableArray *invocations = [[NSMutableArray alloc] init];
    [self _addInvocationsForClass:self withParams:params toInvocations:invocations];
    
    if (invocations.count == 0) {
        @throw [NSException exceptionWithName:@"DRYParameterizedTestCaseException" reason:[NSString stringWithFormat:@"You should provide at least one instance method starting with testWithParamer, having 1 parameter in your parametirzed test class %@!", self] userInfo:nil];
    }
    return [[super testInvocations] arrayByAddingObjectsFromArray:invocations];
}

+ (void)_addInvocationsForClass:(Class)clazz withParams:(NSArray *)params toInvocations:(NSMutableArray *)invocations {
    unsigned int methodCount;
    Method *methods = class_copyMethodList(clazz, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSString *selectorName = NSStringFromSelector(sel);
        if ([selectorName hasPrefix:@"testWithParameter"] && method_getNumberOfArguments(method) == 3) {
            NSString *suffix = [selectorName substringFromIndex:@"testWithParameter".length];
            suffix = [suffix stringByReplacingOccurrencesOfString:@":" withString:@""];
            IMP imp = class_getMethodImplementation(self, sel);
            
            int j = 0;
            for (id param in params) {
                NSString *testName = [self _testNameForParam:param atIndex:j withSuffix:suffix];
                SEL testSEL = NSSelectorFromString(testName);
                BOOL succeeded = class_addMethod(self, testSEL, imp, method_getTypeEncoding(class_getInstanceMethod(self, sel)));
                if (!succeeded) {
                    @throw [NSException exceptionWithName:@"DRYParameterizedTestCaseException" reason:[NSString stringWithFormat:@"Test method for parameters %@ could not be added", param] userInfo:nil];
                } else {
                    NSMethodSignature *signature = [self instanceMethodSignatureForSelector:sel];
                    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:signature];
                    
                    id actualParam = [param respondsToSelector:@selector(parameter)] ? [param parameter] : param;
                    inv.selector = testSEL;
                    [inv setArgument:(void *)&actualParam atIndex:2];
                    [inv retainArguments];
                    [invocations addObject:inv];
                }
                j++;
            }
            
        }
    }
    free(methods);
    
    if (clazz.superclass) {
        [self _addInvocationsForClass:clazz.superclass withParams:params toInvocations:invocations];
    }
}

+ (NSString *)_testNameForParam:(id)param atIndex:(int)index withSuffix:(NSString *)suffix {
    if ([param isKindOfClass:[NSArray class]]) {
        return [NSString stringWithFormat:@"testWith(%@)", [param componentsJoinedByString:@":"]];
    } else if ([param isKindOfClass:[NSDictionary class]] && [param objectForKey:@"testName"]) {
        return [param objectForKey:@"testName"];
    } else if ([param respondsToSelector:@selector(testName)]) {
        return [param testName];
    } else {
        return [NSString stringWithFormat:@"testForParamAtIndex_%@%@",  @(index), suffix.length > 0 ? [NSString stringWithFormat:@"_%@", suffix] : @""];
    }
}

@end
