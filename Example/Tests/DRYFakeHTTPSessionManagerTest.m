//
//  DRYFakeHTTPSessionManagerTest.m
//  DRYTestUtilities
//
//  Created by Joris Dubois on 27/07/15.
//  Copyright (c) 2015 Michael Seghers. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DRYFakeHTTPSessionManager.h"

@interface DRYFakeHTTPSessionManagerTest : XCTestCase {
	DRYFakeHTTPSessionManager *_fakeHTTPSessionManager;
	NSString *_urlString;
	NSDictionary *_requestParameters;
	NSObject *_expectedResult;
	NSError *_expectedError;
	NSURLSessionDataTask *_expectedDataTask;
}

@end

@implementation DRYFakeHTTPSessionManagerTest

- (void)setUp {
	[super setUp];
	_urlString = @"urlStringValue";
	_requestParameters = @{@"dictionaryKey" : @"dictionaryValue"};
	_expectedResult = [[NSObject alloc] init];
	_expectedError = [[NSError alloc] initWithDomain:@"domainValue" code:0 userInfo:@{}];
	_expectedDataTask = [[NSURLSessionDataTask alloc] init];
	_fakeHTTPSessionManager = [[DRYFakeHTTPSessionManager alloc] init];
}

#pragma mark - Return ExpectedDataTask

- (void)testGETDoesReturnExpectedDataTask {
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	NSURLSessionDataTask *task = [_fakeHTTPSessionManager GET:nil parameters:nil success:nil failure:nil];
	XCTAssert([task isEqual:_expectedDataTask]);
}

- (void)testHEADDoesReturnExpectedDataTask {
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	NSURLSessionDataTask *task = [_fakeHTTPSessionManager HEAD:nil parameters:nil success:nil failure:nil];
	XCTAssert([task isEqual:_expectedDataTask]);
}

- (void)testPOSTDoesReturnExpectedDataTask {
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	NSURLSessionDataTask *task = [_fakeHTTPSessionManager POST:nil parameters:nil success:nil failure:nil];
	XCTAssert([task isEqual:_expectedDataTask]);
}

- (void)testPOSTWithConstructingBodyWithBlockDoesReturnExpectedDataTask {
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	NSURLSessionDataTask *task = [_fakeHTTPSessionManager POST:nil parameters:nil constructingBodyWithBlock:nil success:nil failure:nil];
	XCTAssert([task isEqual:_expectedDataTask]);
}

- (void)testPUTDoesReturnExpectedDataTask {
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	NSURLSessionDataTask *task = [_fakeHTTPSessionManager PUT:nil parameters:nil success:nil failure:nil];
	XCTAssert([task isEqual:_expectedDataTask]);
}

- (void)testPATCHDoesReturnExpectedDataTask {
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	NSURLSessionDataTask *task = [_fakeHTTPSessionManager PATCH:nil parameters:nil success:nil failure:nil];
	XCTAssert([task isEqual:_expectedDataTask]);
}

- (void)testDELETEDoesReturnExpectedDataTask {
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	NSURLSessionDataTask *task = [_fakeHTTPSessionManager DELETE:nil parameters:nil success:nil failure:nil];
	XCTAssert([task isEqual:_expectedDataTask]);
}

#pragma mark - RequestMethod

- (void)testDoesSetCorrectDefaultRequestMethod {
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodNONE);
}

- (void)testDoesRecordCorrectRequestMethodForGET {
	[_fakeHTTPSessionManager GET:nil parameters:nil success:nil failure:nil];
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodGET);
}

- (void)testDoesRecordCorrectRequestMethodForHEAD {
	[_fakeHTTPSessionManager HEAD:nil parameters:nil success:nil failure:nil];
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodHEAD);
}

- (void)testDoesRecordCorrectRequestMethodForPOST {
	[_fakeHTTPSessionManager POST:nil parameters:nil success:nil failure:nil];
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodPOST);
}

- (void)testDoesRecordCorrectRequestMethodForPOSTWithConstructingBodyWithBlock {
	[_fakeHTTPSessionManager POST:nil parameters:nil constructingBodyWithBlock:nil success:nil failure:nil];
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodPOST);
}

- (void)testDoesRecordCorrectRequestMethodForPUT {
	[_fakeHTTPSessionManager PUT:nil parameters:nil success:nil failure:nil];
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodPUT);
}

- (void)testDoesRecordCorrectRequestMethodForPATCH {
	[_fakeHTTPSessionManager PATCH:nil parameters:nil success:nil failure:nil];
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodPATCH);
}

- (void)testDoesRecordCorrectRequestMethodForDELETE {
	[_fakeHTTPSessionManager DELETE:nil parameters:nil success:nil failure:nil];
	XCTAssert(_fakeHTTPSessionManager.requestedMethod == RequestMethodDELETE);
}

#pragma mark - URLString

- (void)testDoesRecordRequestedURLForGET {
	[_fakeHTTPSessionManager GET:_urlString parameters:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestedURL isEqualToString:_urlString]);
}

- (void)testDoesRecordRequestedURLForHEAD {
	[_fakeHTTPSessionManager HEAD:_urlString parameters:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestedURL isEqualToString:_urlString]);
}

- (void)testDoesRecordRequestedURLForPOST {
	[_fakeHTTPSessionManager POST:_urlString parameters:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestedURL isEqualToString:_urlString]);
}

- (void)testDoesRecordRequestedURLForPOSTWithConstructingBodyWithBlock {
	[_fakeHTTPSessionManager POST:_urlString parameters:nil constructingBodyWithBlock:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestedURL isEqualToString:_urlString]);
}

- (void)testDoesRecordRequestedURLForPUT {
	[_fakeHTTPSessionManager PUT:_urlString parameters:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestedURL isEqualToString:_urlString]);
}

- (void)testDoesRecordRequestedURLForPATCH {
	[_fakeHTTPSessionManager PATCH:_urlString parameters:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestedURL isEqualToString:_urlString]);
}

- (void)testDoesRecordRequestedURLForDELETE {
	[_fakeHTTPSessionManager DELETE:_urlString parameters:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestedURL isEqualToString:_urlString]);
}

#pragma mark - RequestParameters

- (void)testDoesRecordRequestParametersForGET {
	[_fakeHTTPSessionManager GET:nil parameters:_requestParameters success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestParameters isEqual:_requestParameters]);
}

- (void)testDoesRecordRequestParametersForHEAD {
	[_fakeHTTPSessionManager HEAD:nil parameters:_requestParameters success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestParameters isEqual:_requestParameters]);
}

- (void)testDoesRecordRequestParametersForPOST {
	[_fakeHTTPSessionManager POST:nil parameters:_requestParameters success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestParameters isEqual:_requestParameters]);
}

- (void)testDoesRecordRequestParametersForPOSTWithConstructingBodyWithBlock {
	[_fakeHTTPSessionManager POST:nil parameters:_requestParameters constructingBodyWithBlock:nil success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestParameters isEqual:_requestParameters]);
}

- (void)testDoesRecordRequestParametersForPUT {
	[_fakeHTTPSessionManager PUT:nil parameters:_requestParameters success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestParameters isEqual:_requestParameters]);
}

- (void)testDoesRecordRequestParametersForPATCH {
	[_fakeHTTPSessionManager PATCH:nil parameters:_requestParameters success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestParameters isEqual:_requestParameters]);
}

- (void)testDoesRecordRequestParametersForDELETE {
	[_fakeHTTPSessionManager DELETE:nil parameters:_requestParameters success:nil failure:nil];
	XCTAssert([_fakeHTTPSessionManager.requestParameters isEqual:_requestParameters]);
}

#pragma mark - SuccessBlock

- (void)testGETDoesExecuteSuccessBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager GET:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([task isEqual:_expectedDataTask]);
	} failure:nil];
}

- (void)testGETDoesExecuteSuccessBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	[_fakeHTTPSessionManager GET:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([responseObject isEqual:_expectedResult]);
	} failure:nil];
}

- (void)testHEADDoesExecuteSuccessBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager HEAD:nil parameters:nil success:^(NSURLSessionDataTask *task) {
		XCTAssert([task isEqual:_expectedDataTask]);
	} failure:nil];
}

- (void)testPOSTDoesExecuteSuccessBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager POST:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([task isEqual:_expectedDataTask]);
	} failure:nil];
}

- (void)testPOSTDoesExecuteSuccessBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	[_fakeHTTPSessionManager POST:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([responseObject isEqual:_expectedResult]);
	} failure:nil];
}

- (void)testPOSTWithConstructingBodyWithBlockDoesExecuteSuccessBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager POST:nil parameters:nil constructingBodyWithBlock:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([task isEqual:_expectedDataTask]);
	} failure:nil];
}

- (void)testPOSTWithConstructingBodyWithBlockDoesExecuteSuccessBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	[_fakeHTTPSessionManager POST:nil parameters:nil constructingBodyWithBlock:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([responseObject isEqual:_expectedResult]);
	} failure:nil];
}

- (void)testPUTDoesExecuteSuccessBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager PUT:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([task isEqual:_expectedDataTask]);
	} failure:nil];
}

- (void)testPUTDoesExecuteSuccessBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	[_fakeHTTPSessionManager PUT:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([responseObject isEqual:_expectedResult]);
	} failure:nil];
}

- (void)testPATCHDoesExecuteSuccessBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager PATCH:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([task isEqual:_expectedDataTask]);
	} failure:nil];
}

- (void)testPATCHDoesExecuteSuccessBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	[_fakeHTTPSessionManager PATCH:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([responseObject isEqual:_expectedResult]);
	} failure:nil];
}

- (void)testDELETEDoesExecuteSuccessBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager DELETE:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([task isEqual:_expectedDataTask]);
	} failure:nil];
}

- (void)testDELETEDoesExecuteSuccessBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedResult = _expectedResult;
	[_fakeHTTPSessionManager DELETE:nil parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
		XCTAssert([responseObject isEqual:_expectedResult]);
	} failure:nil];
}

#pragma mark - FailureBlock

- (void)testGETDoesExecuteFailureBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager GET:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([task isEqual:_expectedDataTask]);
	}];
}

- (void)testGETDoesExecuteFailureBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	[_fakeHTTPSessionManager GET:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([error isEqual:_expectedError]);
	}];
}

- (void)testHEADDoesExecuteFailureBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager HEAD:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([task isEqual:_expectedDataTask]);
	}];
}

- (void)testPOSTDoesExecuteFailureBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager POST:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([task isEqual:_expectedDataTask]);
	}];
}

- (void)testPOSTDoesExecuteFailureBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	[_fakeHTTPSessionManager POST:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([error isEqual:_expectedError]);
	}];
}

- (void)testPOSTWithConstructingBodyWithBlockDoesExecuteFailureBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager POST:nil parameters:nil constructingBodyWithBlock:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([task isEqual:_expectedDataTask]);
	}];
}

- (void)testPOSTWithConstructingBodyWithBlockDoesExecuteFailureBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	[_fakeHTTPSessionManager POST:nil parameters:nil constructingBodyWithBlock:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([error isEqual:_expectedError]);
	}];
}

- (void)testPUTDoesExecuteFailureBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager PUT:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([task isEqual:_expectedDataTask]);
	}];
}

- (void)testPUTDoesExecuteFailureBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	[_fakeHTTPSessionManager PUT:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([error isEqual:_expectedError]);
	}];
}

- (void)testPATCHDoesExecuteFailureBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager PATCH:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([task isEqual:_expectedDataTask]);
	}];
}

- (void)testPATCHDoesExecuteFailureBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	[_fakeHTTPSessionManager PATCH:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([error isEqual:_expectedError]);
	}];
}

- (void)testDELETEDoesExecuteFailureBlockWithCorrectDataTaskWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	_fakeHTTPSessionManager.expectedDataTask = _expectedDataTask;
	[_fakeHTTPSessionManager DELETE:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([task isEqual:_expectedDataTask]);
	}];
}

- (void)testDELETEDoesExecuteFailureBlockWithCorrectResponseObjectWhenExpectedResultIsPresent {
	_fakeHTTPSessionManager.expectedError = _expectedError;
	[_fakeHTTPSessionManager DELETE:nil parameters:nil success:nil failure:^(NSURLSessionDataTask *task, NSError *error) {
		XCTAssert([error isEqual:_expectedError]);
	}];
}

@end
