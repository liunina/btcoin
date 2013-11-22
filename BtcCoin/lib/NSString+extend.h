//
//  NSString+extend.h
//  iWork
//
//  Created by liunian on 12-12-11.
//  Copyright (c) 2012年 liunian. All rights reserved.
//

#import <Foundation/Foundation.h>

//Functions for Encoding Data.
@interface NSData (WBEncode)
- (NSString *)MD5EncodedString;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;
- (NSString *)base64EncodedString;
@end

//Functions for Encoding String.
@interface NSString (WBEncode)
- (NSString *)MD5EncodedString;
- (NSData *)HMACSHA1EncodedDataWithKey:(NSString *)key;
- (NSString *)base64EncodedString;
- (NSString *)URLEncodedString;
- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding;
@end

@interface NSString (WBUtil)

+ (NSString *)GUIDString;

@end

