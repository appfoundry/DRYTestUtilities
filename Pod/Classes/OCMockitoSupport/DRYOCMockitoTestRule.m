//
//  DRYOCMockitoTestRule.m
//  Pods
//
//  Created by Michael Seghers on 14/07/16.
//
//

#import "DRYOCMockitoTestRule.h"
#import <objc/runtime.h> 
#import <OCMockito/OCMockito.h>

@implementation DRYOCMockitoTestRule

+ (instancetype)mockitoTestRule {
    return [[self alloc] init];
}

- (void)before {
    
}

- (NSInvocation *)apply:(NSInvocation *)invocation {
    id test = invocation.target;
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([test class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        const char *propertyAttrs = property_getAttributes(property);
        NSString *propertiesAsString = [NSString stringWithUTF8String:propertyAttrs];
        
        NSArray<NSString *> *comps = [propertiesAsString componentsSeparatedByString:@","];
        NSString *typeInfo = comps.firstObject;
        //Non weak, non readonly object types
        if ([comps indexOfObject:@"R"] == NSNotFound && [comps indexOfObject:@"W"] == NSNotFound && [typeInfo hasPrefix:@"T@"]) {
            NSLog(@"%@", typeInfo);
            NSRegularExpression *e = [[NSRegularExpression alloc] initWithPattern:@"T?@?\\\"?([^\\\"<>T@]*)(<([^>]*)>)?\\\"?" options:0 error:nil];
            NSArray<NSTextCheckingResult *> *matches = [e matchesInString:typeInfo options:0 range:NSMakeRange(0, typeInfo.length)];
            NSMutableArray *protocols = [[NSMutableArray alloc] init];
            Class objectType = nil;
            for (NSTextCheckingResult *result in matches) {
                if (1 < result.numberOfRanges) {
                    NSString *potentialObjectType = [typeInfo substringWithRange:[result rangeAtIndex:1]];
                    objectType = potentialObjectType.length > 0 ? NSClassFromString(potentialObjectType) : objectType;
                }
                
                if (3 < result.numberOfRanges && [result rangeAtIndex:3].location != NSNotFound) {
                    NSString *potentialProtocol = [typeInfo substringWithRange:[result rangeAtIndex:3]];
                    if (potentialProtocol.length > 0) {
                        [protocols addObject:NSProtocolFromString(potentialProtocol)];
                    }
                }
            }
            
            id mock = nil;
            if (objectType && protocols.count == 0) {
                mock = MKTMock(objectType);
            } else if (objectType && protocols.count == 1) {
                mock = MKTMockObjectAndProtocol(objectType, protocols.firstObject);
            } else if (!objectType && protocols.count == 1) {
                mock = MKTMockProtocol(protocols.firstObject);
            }
            
            if (mock) {
                [test setValue:mock forKey:[NSString stringWithUTF8String:property_getName(property)]];
            }
        }
    }
    free(properties);
    return invocation;
}

- (void)after {
    
}

@end
