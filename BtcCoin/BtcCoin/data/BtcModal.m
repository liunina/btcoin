//
//  BtcModal.m
//  BtcCoin
//
//  Created by liunian on 13-11-15.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "BtcModal.h"

@implementation BtcModal


- (void)setBuy:(NSString *)buy{
    if ([buy isKindOfClass:[NSString class]]) {
        _buy = buy;
    }else if ([buy isKindOfClass:[NSNumber class]]){
        _buy = [(NSNumber *)buy stringValue];
    }
}

- (void)setHigh:(NSString *)high{
    if ([high isKindOfClass:[NSString class]]) {
        _high = high;
    }else if ([high isKindOfClass:[NSNumber class]]){
        _high = [(NSNumber *)high stringValue];
    }
}

- (void)setLast:(NSString *)last{
    if ([last isKindOfClass:[NSString class]]) {
        if ([_last floatValue] == [last floatValue]) {
            self.trend = Fair;
        }else if ([_last floatValue] > [last floatValue]){
            self.trend = PullDown;
        }else if ([_last floatValue] < [last floatValue]){
            self.trend = GoUp;
        }else{
            self.trend = none;
        }
        _last = last;
    }else if ([last isKindOfClass:[NSNumber class]]){
        
        if ([_last floatValue] == [last floatValue]) {
            self.trend = Fair;
        }else if ([_last floatValue] > [last floatValue]){
            self.trend = PullDown;
        }else if ([_last floatValue] < [last floatValue]){
            self.trend = GoUp;
        }else{
            self.trend = none;
        }
        
        _last = [(NSNumber *)last stringValue];
    }
}

- (void)setLow:(NSString *)low{
    if ([low isKindOfClass:[NSString class]]) {
        
        
        _low = low;
    }else if ([low isKindOfClass:[NSNumber class]]){
        _low = [(NSNumber *)low stringValue];
    }
}

- (void)setSell:(NSString *)sell{
    if ([sell isKindOfClass:[NSString class]]) {
        _sell = sell;
    }else if ([sell isKindOfClass:[NSNumber class]]){
        _sell = [(NSNumber *)sell stringValue];
    }
}

- (void)setVolStr:(NSString *)volStr{
    if ([volStr isKindOfClass:[NSString class]]) {
        _volStr = volStr;
    }else if ([volStr isKindOfClass:[NSNumber class]]){
        _volStr = [(NSNumber *)volStr stringValue];
    }
}


@end
