//
//  DRYOCMockitoTestRule.h
//  Pods
//
//  Created by Michael Seghers on 14/07/16.
//
//

#import <Foundation/Foundation.h>
#import <DRYTestUtilities/DRYTestRule.h>

@class MKTBaseMockObject;

/**
 Test rule to automatically inject OCMockito mocks into your test's properties which names start with "mock".

 The test rule will look for properties that are both writable (not readonly) and retained (strong) and inject them with a mock matching the property's type.
 Only OCMockito supported mocks are injected:
 - Object mock, eg. NSObject
 - Protocol mock, eg. id<YourProtocol>
 - Object and Protocol mock, eg. NSObject<YourProtocol>
 */
@interface DRYOCMockitoTestRule : NSObject<DRYTestRule>

/**
 Creates a DRYOCMockitoTestRule instance.
 */
+ (instancetype)mockitoTestRule;

/**
 You can use this method to inject any concrete object instance with mock objects.

 @param prefix Only properties which names start with the given prefix, will be injected.
 @param object The object that should be injected with mocks.
 */
- (void)injectMocksIntoPropertiesWithPrefix:(NSString *)prefix ofObject:(id)object;

@end
