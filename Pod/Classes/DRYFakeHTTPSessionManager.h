//
//  DRYFakeHTTPSessionManager.h
//  Pods
//
//  Created by Joris Dubois on 27/07/15.
//
//

#import <Foundation/Foundation.h>
#import <DRYUtilities/DRYHTTPSessionManager.h>

typedef NS_ENUM(NSInteger, RequestMethod){
    RequestMethodNONE,
    RequestMethodGET,
    RequestMethodHEAD,
    RequestMethodPOST,
    RequestMethodPUT,
    RequestMethodDELETE,
    RequestMethodPATCH
};

@interface DRYFakeHTTPSessionManager : NSObject<DRYHTTPSessionManager>

@property (nonatomic, strong) NSURLSessionDataTask *expectedDataTask;
@property (nonatomic, readonly) NSString *requestedURL;
@property (nonatomic, readonly) id requestParameters;
@property (nonatomic, strong) id expectedResult;
@property (nonatomic, strong) NSError *expectedError;
@property (nonatomic) RequestMethod requestedMethod;

@end