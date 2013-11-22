//
//  Util.h
//  DayPainting
//
//  Created by nian liu on 12-7-28.
//  Copyright (c) 2012年 banma.com. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum _ALIGNTYPE
{
    ALIGNTYPE_LEFT,
    ALIGNTYPE_CENTER,
    ALIGNTYPE_RIGHT,
}ALIGNTYPE;

@interface Util : NSObject
#pragma mark - JSON Convert
/*
 *  JSON转换成Dict
 */
//+ (NSDictionary *)convertJSONToDict:(NSString *)string;

/*
 *  Dict转换成JSON
 */
//+ (NSString *)convertDictToJSON:(NSDictionary *)dict;

/*
 *  获取Dictionary中的元素,主要防止服务器发送@""或者obje-c转化成NSNull
 */
+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict;
+ (id)getElementForKey:(id)key fromDict:(NSDictionary *)dict forClass:(Class)class;

+ (NSInteger)getAlign:(ALIGNTYPE)type;

+ (UIColor *)getColor:(NSString *) hexColor;
@end
