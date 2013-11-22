//
//  BtcData.h
//  BtcCoin
//
//  Created by liunian on 13-11-15.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BtcModal.h"

@interface BtcData : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *ticker;
@property (nonatomic, retain) NSString *link;

@property (nonatomic, retain) BtcModal *btcModal;
@property (nonatomic, assign) NSString *coinSign;
@end
