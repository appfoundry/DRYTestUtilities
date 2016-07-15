//
//  DRYOCMockitoTestRule.h
//  Pods
//
//  Created by Michael Seghers on 14/07/16.
//
//

#import <Foundation/Foundation.h>
#import <DRYTestUtilities/DRYTestRule.h>

@interface DRYOCMockitoTestRule : NSObject<DRYTestRule>

+ (instancetype)mockitoTestRule;

@end
