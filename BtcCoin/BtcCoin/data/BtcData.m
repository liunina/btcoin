//
//  BtcData.m
//  BtcCoin
//
//  Created by liunian on 13-11-15.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "BtcData.h"

@implementation BtcData

- (NSString *)coinSign{
    if ([self.ticker isEqualToString:@"796futuresTicker"] || [self.ticker isEqualToString:@"MtGoxTicker"] ||[self.ticker isEqualToString:@"bitstampTicker"]) {
        return @"$";
    }else{
        return @"￥";
    }
    return @"";
}
@end
