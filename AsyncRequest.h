//
//  AsyncRequest.h
//  readinglist
//
//  Created by Akshay Jawharker on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(void);
typedef void(^FailedBlock)(void);

@interface AsyncRequest : NSObject

-(void) requestWithURL:(NSString*) urlString;
-(void) startAsync;
-(void) cancelAsync;
-(void) setOnCompleteBlock:(CompletionBlock)completeBlock;
-(void) setOnFailureBlock:(FailedBlock)failedBlock;


@property(nonatomic, retain) NSMutableData* responseData;
@property(nonatomic, copy) NSURL* requestURL;
@property(nonatomic, copy) CompletionBlock completionBlock;
@property(nonatomic, copy) FailedBlock failureBlock;

@end

NSURLConnection* connection;