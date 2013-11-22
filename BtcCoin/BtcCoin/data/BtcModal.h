//
//  BtcModal.h
//  BtcCoin
//
//  Created by liunian on 13-11-15.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 buy = "448.61";
 high = "467.90";
 last = "450.00";
 low = "422.22";
 sell = "450.00";
 vol = "19105.26";
 */

typedef enum TrendType{
    none = 0,
    GoUp,
    PullDown,
    Fair,//持平
}TrendType;
@interface BtcModal : NSObject

@property (nonatomic, retain) NSString *buy; //买一价
@property (nonatomic, retain) NSString *high; //最高价
@property (nonatomic, retain) NSString *last; //最近成交价
@property (nonatomic, retain) NSString *low; // 最低价
@property (nonatomic, retain) NSString *sell; //卖一价
@property (nonatomic, retain) NSString *volStr; //成交量

@property (nonatomic, assign) TrendType trend;

@end
