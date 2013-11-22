//
//  Debug.h
//  DayPainting
//
//  Created by nian liu on 12-7-18.
//  Copyright (c) 2012年 banma.com. All rights reserved.
//

#ifndef DEBUG_H
#define DEBUG_H

#if DEBUG
#define BMLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define BMLog(xx, ...)  ((void)0)
#endif

#define LogFont()  NSArray *familyNames = [UIFont familyNames];  \
for( NSString *familyName in familyNames ){  \
printf( "Family: %s \n", [familyName UTF8String] );  \
NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];  \
for( NSString *fontName in fontNames ){  \
printf( "\tFont: %s \n", [fontName UTF8String] );  \
}  \
}
#endif