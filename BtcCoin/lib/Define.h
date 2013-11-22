//
//  Define.h
//  DailyPoem
//
//  Created by liunian on 12-11-16.
//  Copyright (c) 2012年 liunian. All rights reserved.
//

#ifndef DailyPoem_Define_h
#define DailyPoem_Define_h

#import "Util.h"
#import "UIColor+MLPFlatColors.h"
/*
 *  APP信息
 */
#define APP_NAME    [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] stringValue]
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_DEV     @"iphone"
#define DEV_UUID    @""

#define BUGetElemForKeyFromDict(__key, __dict) [Util getElementForKey:__key fromDict:__dict]
#define BUGetObjFromDict(__key, __dict, __class) [Util getElementForKey:__key fromDict:__dict forClass:__class]

#define BUGetWBEngineForSina  [WBEngineManager getWBEngineSinaWithAppKey:SINAAPPKEY appSecret:SINAAPPSECRET]
#define BUGetWBEngineForTx    [WBEngineManager getWBEngineTXWithAppKey:TXAPPKEY appSecret:TXAPPSECRET]

#define DICT_KEY_SINA_WEIBO_USERINFO    @"DICT_KEY_SINA_WEIBO_USERINFO"
#define DICT_KEY_TENCENT_WEIBO_USERINFO @"DICT_KEY_TENCENT_WEIBO_USERINFO"
#define DICT_KEY_PUSH_DEVICE_TOKEN      @"DICT_KEY_PUSH_DEVICE_TOKEN"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define RELEASE_SAFELY(__POINTER) { __POINTER = nil; }
#define REMOVE_SAFELY(__POINTER) { [__POINTER removeFromSuperview]; __POINTER = nil; }
#define INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate];[__TIMER release]; __TIMER = nil; }

#define IMGFROMBUNDLE( X )	 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"" ]]
#define IMGNAMED( X )	     [UIImage imageNamed:X]


#ifndef SET_PARAM
#define SET_PARAM(__value__, __key__, __parms__) \
if (nil!=__value__) {\
[__parms__ setObject:__value__ forKey:__key__];\
}
#endif

#define MKDirFileCache [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"FileCache"]
#define MKCacheDir     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define MKDocumentDir  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

/************************************************************************
 *  开发平台引擎 相关
 ************************************************************************/
#define PUGetOFEngineForSina  [OFEngineManager getWBEngineSinaWithAppKey:SINAAPPKEY appSecret:SINAAPPSECRET]
#define PUGetOFEngineForTx    [OFEngineManager getWBEngineTXWithAppKey:TXAPPKEY appSecret:TXAPPSECRET]
#define PUGetOFEngineForQZone [OFEngineManager getQZoneEngineWithAppId:QZONEAPPID appKey:QZONEAPPKEY]

#define SINAAPPKEY           @"2679290066"  //sina APPKEY
#define SINAAPPSECRET        @"d1bed6d84c87e5ca43596e0d82fba7a4"  //sina APPSECRET

#define TXAPPKEY             @""  //tx appkey
#define TXAPPSECRET          @""  //tx APPSECRET

#define QZONEAPPID           @""    //QZONE appId
#define QZONEAPPKEY          @""   //qzone appKey

#define SINA_REDIRECT_URI         @"http://xjan.net"
#define TX_REDIRECT_URI           @"http://"
#define QZONE_REDIRECT_URI        @"http://"

#define FONT_FZLTHJW(X) [UIFont fontWithName:@"FZLanTingHei-R-GBK" size:X]
#define FONT_SYSTEM(X) [UIFont systemFontOfSize:X]

//对齐方式
#define ALIGN_LEFT      [Util getAlign:ALIGNTYPE_LEFT]
#define ALIGN_CENTER    [Util getAlign:ALIGNTYPE_CENTER]
#define ALIGN_RIGHT     [Util getAlign:ALIGNTYPE_RIGHT]

//lineBreakMode
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 60000
#define NSUITextAlignment UITextAlignment
#define NSUILineBreakMode UILineBreakMode

#define NSUILineBreakModeWordWrap             UILineBreakModeWordWrap
#define NSUILineBreakModeCharacterWrap        UILineBreakModeCharacterWrap
#define NSUILineBreakModeClip                 UILineBreakModeClip
#define NSUILineBreakModeHeadTruncation       UILineBreakModeHeadTruncation
#define NSUILineBreakModeTailTruncation       UILineBreakModeTailTruncation
#define NSUILineBreakModeMiddleTruncation     UILineBreakModeMiddleTruncation
#else
#define NSUITextAlignment NSTextAlignment
#define NSUILineBreakMode NSLineBreakMode

#define NSUILineBreakModeWordWrap             NSLineBreakByWordWrapping
#define NSUILineBreakModeCharacterWrap        NSLineBreakByCharWrapping
#define NSUILineBreakModeClip                 NSLineBreakByClipping
#define NSUILineBreakModeHeadTruncation       NSLineBreakByTruncatingHead
#define NSUILineBreakModeTailTruncation       NSLineBreakByTruncatingTail
#define NSUILineBreakModeMiddleTruncation     NSLineBreakByTruncatingMiddle
#endif

/************************************************************************
 *  开发平台引擎 相关
 ************************************************************************/
//

#define ATTRIBUTE_INFO(__key__, __className__, __keyClassName__) [NSDictionary dictionaryWithObjectsAndKeys:__key__, @"key",\
__className__, @"className",\
__keyClassName__, @"keyClassName",\
nil]

#define ATTRIBUTE_INFO_NUMBER(__key__) ATTRIBUTE_INFO(__key__, @"NSNull", @"NSNumber")


#define KEY_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"key"]
#define CLASSNAME_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"className"]
#define KEYCLASSNAME_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"keyClassName"]
//

#define KEY_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"key"]
#define CLASSNAME_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"className"]
#define KEYCLASSNAME_FROM_ATTRIBUTE_INFO(__info__) [__info__ objectForKey:@"keyClassName"]

#ifndef isDictWithCountMoreThan0

#define isDictWithCountMoreThan0(__dict__) \
(__dict__!=nil && \
[__dict__ isKindOfClass:[NSDictionary class] ] && \
__dict__.count>0)

#endif

#ifndef isArrayWithCountMoreThan0

#define isArrayWithCountMoreThan0(__array__) \
(__array__!=nil && \
[__array__ isKindOfClass:[NSArray class] ] && \
__array__.count>0)

#endif
#endif
