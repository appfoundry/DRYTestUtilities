//
//  DRYTestRule.h
//  Pods
//
//  Created by Michael Seghers on 01/07/16.
//
//

#import <Foundation/Foundation.h>

@protocol DRYTestRule <NSObject>

- (void)before;
- (NSInvocation *)apply:(NSInvocation *)invocation;
- (void)after;

@end
