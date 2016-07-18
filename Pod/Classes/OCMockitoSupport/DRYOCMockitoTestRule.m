//
//  DRYOCMockitoTestRule.m
//  Pods
//
//  Created by Michael Seghers on 14/07/16.
//
//

#import <objc/runtime.h>
#import <OCMockito/OCMockito.h>
#import "DRYOCMockitoTestRule.h"
#import "MKTInvocationContainer.h"
#import "MKT_TPDWeakProxy.h"

@interface MKT_TPDWeakProxy (IKnowWhatIsGoingOnBehindTheScences)
@property (nonatomic, weak) id theObject;
@end

@interface MKTObjectAndProtocolMock (IKnowWhatIsGoingOnBehindTheScences)
@property (nonatomic, strong, readonly) Class mockedClass;
@end

@interface MKTObjectMock (IKnowWhatIsGoingOnBehindTheScences)
@property (nonatomic, strong, readonly) Class mockedClass;
@end




@interface MKTOngoingStubbing (IKnowWhatIsGoingOnBehindTheScences)
@property (nonatomic, readonly) MKTInvocationContainer *invocationContainer;
@end

@implementation DRYOCMockitoTestRule

+ (instancetype)mockitoTestRule {
    return [[self alloc] init];
}

- (void)before {

}

- (NSInvocation *)apply:(NSInvocation *)invocation {
    id test = invocation.target;
    [self injectMocksIntoPropertiesWithPrefix:@"mock" ofObject:test];
    return invocation;
}

- (void)injectMocksIntoPropertiesWithPrefix:(NSString *)prefix ofObject:(id)object {
    [self _injectMocksIntoPropertiesWithPrefix:prefix ofObject:object forClass:[object class]];
}

- (void)_injectMocksIntoPropertiesWithPrefix:(NSString *)prefix ofObject:(id)object forClass:(Class)objectType  {
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(objectType, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t prop = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(prop)];
        if ([propertyName hasPrefix:prefix]) {
            [self _checkAndInjectMockIntoProperty:object property:prop];
        }
    }
    free(properties);

    if ([objectType superclass]) {
        [self _injectMocksIntoPropertiesWithPrefix:prefix ofObject:object forClass:[objectType superclass]];
    }
}

- (void)_checkAndInjectMockIntoProperty:(id)object property:(objc_property_t)prop {
    const char *propertyAttrs = property_getAttributes(prop);
    NSString *propertiesAsString = [NSString stringWithUTF8String:propertyAttrs];
    NSString *typeInfo = [propertiesAsString componentsSeparatedByString:@","].firstObject;
    //Non weak, non readonly object types
    if ([[propertiesAsString componentsSeparatedByString:@","] indexOfObject:@"R"] == NSNotFound && [[propertiesAsString componentsSeparatedByString:@","] indexOfObject:@"W"] == NSNotFound && [typeInfo hasPrefix:@"T@"]) {
        id currentValue = [object valueForKey:[NSString stringWithUTF8String:property_getName(prop)]];
        if (currentValue == nil) {
            [self _createMockBasedOnTypeInfo:typeInfo andInjectProperty:prop onObject:object];
        }

    }
}

- (void)_createMockBasedOnTypeInfo:(NSString *)typeInfo andInjectProperty:(objc_property_t)prop onObject:(id)object {
    NSRegularExpression *e = [[NSRegularExpression alloc] initWithPattern:@"T?@?\\\"?([^\\\"<>T@]*)(<([^>]*)>)?\\\"?" options:0 error:nil];
    NSArray<NSTextCheckingResult *> *matches = [e matchesInString:typeInfo options:0 range:NSMakeRange(0, typeInfo.length)];
    NSMutableArray *protocols = [[NSMutableArray alloc] init];
    Class objectType = nil;
    for (NSTextCheckingResult *result in matches) {
        objectType = [self _objectTypeFromTypeInfo:typeInfo withCheckingResult:result] ?: objectType;
        [self _addPropertyTypesFromTypeInfo:typeInfo toProtocols:protocols withCheckingResult:result];
    }

    id mock = [self _createMockForClass:objectType protocols:protocols];
    if (mock) {
        [object setValue:mock forKey:[NSString stringWithUTF8String:property_getName(prop)]];
    }
}

- (void)_addPropertyTypesFromTypeInfo:(NSString *)typeInfo toProtocols:(NSMutableArray *)protocols withCheckingResult:(NSTextCheckingResult *)result {
    if (3 < result.numberOfRanges && [result rangeAtIndex:3].location != NSNotFound) {
        NSString *potentialProtocol = [typeInfo substringWithRange:[result rangeAtIndex:3]];
        if (potentialProtocol.length > 0) {
            [protocols addObject:NSProtocolFromString(potentialProtocol)];
        }
    }
}

- (Class)_objectTypeFromTypeInfo:(NSString *)typeInfo withCheckingResult:(NSTextCheckingResult *)result {
    Class objectType;
    if (1 < result.numberOfRanges) {
        NSString *potentialObjectType = [typeInfo substringWithRange:[result rangeAtIndex:1]];
        objectType = NSClassFromString(potentialObjectType);
    }
    return objectType;
}

- (id)_createMockForClass:(Class)type protocols:(NSArray *)protocols {
    id mock = nil;
    if (type && protocols.count == 0) {
        mock = MKTMock(type);
    } else if (type && protocols.count == 1) {
        mock = MKTMockObjectAndProtocol(type, protocols.firstObject);
    } else if (!type && protocols.count == 1) {
        mock = MKTMockProtocol(protocols.firstObject);
    }
    return mock;
}

- (void)after {

}

@end
