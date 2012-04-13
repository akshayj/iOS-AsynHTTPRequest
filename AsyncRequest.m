//
//  AsyncRequest.m
//  readinglist
//
//  Created by Akshay Jawharker on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AsyncRequest.h"

@implementation AsyncRequest

@synthesize responseData, requestURL, completionBlock, failureBlock;


- (id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

-(void) dealloc
{
    [completionBlock release];
    [failureBlock release];
    [responseData release];
    [super dealloc]; 
}

-(void) requestWithURL:(NSString*) urlString
{
    requestURL = [NSURL URLWithString:urlString];
}

-(void) startAsync
{
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:requestURL
                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                 timeoutInterval:60.0];
    
    connection =  [ [ NSURLConnection alloc] initWithRequest:urlRequest delegate:self ];  
    [urlRequest release];
}

-(void) cancelAsync
{
    [connection cancel];
    [connection release];
}

-(void) setOnCompleteBlock:(CompletionBlock)completeBlock
{
    self.completionBlock = completeBlock;
}

-(void) setOnFailureBlock:(FailedBlock)failedBlock
{
    self.failureBlock = failedBlock;
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [connection release];
    
    self.failureBlock();
}

//Request FAILED
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if( responseData == nil ){
        responseData = [ [ NSMutableData alloc ] initWithCapacity:2048 ];
    }
    
    [responseData appendData : data];
}

//Request COMPLETED
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [connection release];
        
    self.completionBlock();
}

@end
