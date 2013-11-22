//
//  HttpRequest.h
//  iArtHD
//
//  Created by liu nian on 13-3-20.
//  Copyright (c) 2013年 liu nian. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import "JSON.h"

typedef enum HttpMethod{
    HttpMethodGet,
    HttpMethodPost,
}HttpMethod;

#if NS_BLOCKS_AVAILABLE
typedef void (^ASIRequsetBlock)(ASIHTTPRequest *request);
#endif

@interface HttpRequest : ASIFormDataRequest{
    //带ASIHttprequest对象的block
	ASIRequsetBlock _completionReqBlock;
    
	ASIRequsetBlock _failureReqBlock;
}


+ (HttpRequest *)requestWithURLStr:(NSString *)initURLString
                               param:(NSDictionary *)param
                          httpMethod:(HttpMethod)httpMethod
                              isAsyn:(BOOL)isAsyn
                     completionBlock:(ASIRequsetBlock)aCompletionReqBlock
                         failedBlock:(ASIRequsetBlock)aFailedReqBlock;
+ (NSDictionary *)commonParams;

+ (BOOL)isRequestSuccess:(ASIHTTPRequest *)request;

#if NS_BLOCKS_AVAILABLE
- (void)setCompletionReqBlock:(ASIRequsetBlock)aCompletionBlock;
- (void)setFailedReqBlock:(ASIRequsetBlock)aFailedBlock;
#endif

@end