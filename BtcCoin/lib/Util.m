//
//  Util.m
//  DayPainting
//
//  Created by nian liu on 12-7-28.
//  Copyright (c) 2012年 banma.com. All rights reserved.
//

#import "Util.h"

//#import "SBJsonParser.h"
//#import "SBJsonWriter.h"
#import <QuartzCore/QuartzCore.h>

#define SerializeKeyUpdate @"SerializeKeyUpdate"

@interface Util()
+ (UIImage *)image:(UIImage *)image drawInRect:(CGRect)rect;
@end

@implementation Util

+ (NSInteger)getAlign:(ALIGNTYPE)type
{
    CGFloat ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    switch (type)
    {
        case ALIGNTYPE_LEFT:
        {
            if(ver < 6.0)
            {
                return UITextAlignmentLeft;
            }
            else
            {
                return NSTextAlignmentLeft;
            }
        }break;
        case ALIGNTYPE_CENTER:
        {
            if(ver < 6.0)
            {
                return UITextAlignmentCenter;
            }
            else
            {
                return NSTextAlignmentCenter;
            }
        }break;
        case ALIGNTYPE_RIGHT:
        {
            if(ver < 6.0)
            {
                return UITextAlignmentRight;
            }
            else
            {
                return NSTextAlignmentRight;
            }
        }break;
        default:
        {
            if(ver < 6.0)
            {
                return UITextAlignmentLeft;
            }
            else
            {
                return NSTextAlignmentLeft;
            }
        }
            break;
    }
    
}


+ (UIColor *)getColor:(NSString *) hexColor
{
	unsigned int redInt_, greenInt_, blueInt_;
	NSRange rangeNSRange_;
	rangeNSRange_.length = 2;  // 范围长度为2
	
	// 取红色的值
	rangeNSRange_.location = 0;
	[[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
    
	// 取绿色的值
	rangeNSRange_.location = 2;
	[[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
	
	// 取蓝色的值
	rangeNSRange_.location = 4;
	[[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
	
	return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:1.0f];
}

+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict
{
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""]) {
        return nil; //空字符串
    } else if ([obj isKindOfClass:[NSNull class]]) {
        return nil; //空类
    }  
    return obj;
}

+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)class
{
    id obj = [dict objectForKey:key];
    if ([obj isKindOfClass:class]) {
        if ([obj isKindOfClass:[NSString class]] && [obj isEqual:@""]) {
            return nil;
        } else {
            return obj;
        }
    }
    return nil;
}

@end