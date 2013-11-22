//
//  HttpRequest.m
//  iArtHD
//
//  Created by liu nian on 13-3-20.
//  Copyright (c) 2013年 liu nian. All rights reserved.
//

#import "HttpRequest.h"
#import "JSON.h"
#import "NSString+extend.h"

@interface ASIHTTPRequest(protected)

- (void)releaseBlocksOnMainThread;
- (void)reportFinished;
- (void)reportFailure;

@end


@interface HttpRequest(){
}
@end

@implementation HttpRequest

+ (HttpRequest *)requestWithURLStr:(NSString *)initURLString
                               param:(NSDictionary *)param
                          httpMethod:(HttpMethod)httpMethod
                              isAsyn:(BOOL)isAsyn
                     completionBlock:(ASIRequsetBlock)aCompletionBlock
                         failedBlock:(ASIRequsetBlock)aFailedBlock{
    NSMutableDictionary *mParam = [NSMutableDictionary dictionaryWithDictionary:param];
    [mParam addEntriesFromDictionary:[HttpRequest commonParams]];
    param = mParam;
    
    HttpRequest *aRequest = [[HttpRequest alloc] initWithURL:nil];
    [aRequest setValidatesSecureCertificate:NO];
    [aRequest setTimeOutSeconds:30];
    NSMutableString *postString = [NSMutableString stringWithCapacity:0];
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj respondsToSelector:@selector(stringValue)]) {
            obj = [obj stringValue];
        }
        if ([obj isKindOfClass:[NSString class]]) {
            [postString appendString:[NSString stringWithFormat:@"%@=%@&", key, [obj URLEncodedString]] ];
        }
    }];
        
    NSString *requestUrlStr = initURLString;
    if (httpMethod==HttpMethodPost) {
        [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSURL class]] && [[NSFileManager defaultManager] fileExistsAtPath:[obj absoluteString]]) {
                // 添加上传的文件
                
                [aRequest addFile:[obj absoluteString] forKey:key];
            }else if ([obj isKindOfClass:[UIImage class]]){
                // 添加上传的图片
                
                [aRequest addData:UIImagePNGRepresentation(obj) withFileName:key andContentType:@"image/png" forKey:key];
            }else{
                [aRequest addPostValue:obj forKey:key];
            }
        }];
    }else{
        NSInteger questLocation = [initURLString rangeOfString:@"sinaapp"].location;
        if (NSNotFound!=questLocation) {
            requestUrlStr = [NSString stringWithFormat:@"%@?%@", initURLString, postString];
        }else{
            requestUrlStr = [NSString stringWithFormat:@"%@?%@", initURLString, postString];
        }
    }
    
    [aRequest setURL:[NSURL URLWithString:requestUrlStr]];
    
    [aRequest setCompletionReqBlock:aCompletionBlock];
    [aRequest setFailedReqBlock:aFailedBlock];
    
    if (isAsyn) {
        [aRequest startAsynchronous];
    }else{
        [aRequest startSynchronous];
    }
    
#if DEBUG
    if (httpMethod==HttpMethodGet) {
        NSLog(@"URL:%@", requestUrlStr);
    }else{
        NSString *postStr = [[[NSString alloc] initWithData:aRequest.postBody encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"URL:%@, params(POST):%@", requestUrlStr, postStr);
    }
    
#endif
    return aRequest;
}

+ (BOOL)isRequestSuccess:(ASIHTTPRequest *)request{
    NSDictionary *jsonDict = [request.responseString JSONValue];
    NSNumber *codeNum = [jsonDict objectForKey:@"error_code"];
    NSInteger resultCode = [codeNum intValue];
    if (nil!=jsonDict || resultCode == 0) {
        return YES;
    }
    return NO;
}

#if NS_BLOCKS_AVAILABLE
- (void)setCompletionReqBlock:(ASIRequsetBlock)aCompletionBlock{
    [_completionReqBlock release];
	_completionReqBlock = [aCompletionBlock copy];
}

- (void)setFailedReqBlock:(ASIRequsetBlock)aFailedBlock{
    [_failureReqBlock release];
	_failureReqBlock = [aFailedBlock copy];
}


- (void)releaseBlocksOnMainThread
{
	NSMutableArray *blocks = [NSMutableArray array];
	if (_completionReqBlock) {
		[blocks addObject:_completionReqBlock];
		[_completionReqBlock release];
		_completionReqBlock = nil;
	}
	if (_failureReqBlock) {
		[blocks addObject:_failureReqBlock];
		[_failureReqBlock release];
		_failureReqBlock = nil;
	}
	
	[[self class] performSelectorOnMainThread:@selector(releaseBlocks:) withObject:blocks waitUntilDone:[NSThread isMainThread]];
    
    [super releaseBlocksOnMainThread];
}

#endif

- (void)reportFinished
{
#if NS_BLOCKS_AVAILABLE
	if(_completionReqBlock){
		_completionReqBlock(self);
	}
#endif
    [super reportFinished];
}

- (void)reportFailure
{
#if NS_BLOCKS_AVAILABLE
    if(_failureReqBlock){
        _failureReqBlock(self);
    }
#endif
    [super reportFailure];
}

#pragma mark - getter/setter
+ (NSDictionary *)commonParams
{
    static NSDictionary *gCommonParams = nil;
    if (!gCommonParams) {
        gCommonParams = [[NSMutableDictionary alloc] init];
//        if (APP_VERSION) {
//            [(NSMutableDictionary *)gCommonParams setObject:APP_VERSION forKey:@"ver"];
//        }
//        if (APP_DEV && APP_DEV.length>0) {
//            [(NSMutableDictionary *)gCommonParams setObject:APP_DEV forKey:@"dev"];
//        }
    }
    
    return gCommonParams;
}
@end
