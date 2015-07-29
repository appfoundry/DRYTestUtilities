//
//  DRYFakeHTTPSessionManager.m
//  Pods
//
//  Created by Joris Dubois on 27/07/15.
//
//

#import "DRYFakeHTTPSessionManager.h"

@implementation DRYFakeHTTPSessionManager

- (NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    _requestedMethod = RequestMethodGET;
    return [self _recordRequestWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)HEAD:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    _requestedMethod = RequestMethodHEAD;
    return [self _recordHeadRequestWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    _requestedMethod = RequestMethodPOST;
    return [self _recordRequestWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    _requestedMethod = RequestMethodPOST;
    return [self _recordRequestWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    _requestedMethod = RequestMethodPUT;
    return [self _recordRequestWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)PATCH:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    _requestedMethod = RequestMethodPATCH;
    return [self _recordRequestWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    _requestedMethod = RequestMethodDELETE;
    return [self _recordRequestWithURLString:URLString parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)_recordRequestWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    _requestedURL = URLString;
    _requestParameters = parameters;
    if (self.expectedResult) {
        success(self.expectedDataTask, self.expectedResult);
    } else if (self.expectedError) {
        failure(self.expectedDataTask, self.expectedError);
    }
    return self.expectedDataTask;
}

- (NSURLSessionDataTask *)_recordHeadRequestWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    _requestedURL = URLString;
    _requestParameters = parameters;
    if (self.expectedResult) {
        success(self.expectedDataTask);
    } else if (self.expectedError) {
        failure(self.expectedDataTask, self.expectedError);
    }
    return self.expectedDataTask;
}

@end