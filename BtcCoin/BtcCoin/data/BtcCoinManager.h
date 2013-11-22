//
//  BtcCoinManager.h
//  BtcCoin
//
//  Created by liunian on 13-11-14.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubscibeModal.h"

//http://z.btc123.com/lib/jsonProxyTickerInfo.php?type=btceLTCBTCticker&suffix=0.12706584576517344

@class BtcData;
@protocol BtcCoinDelegate <NSObject>
@optional
- (void)BtcCoinManagerDidFinishWithSubscibeModal:(SubscibeModal *)subscibe;
- (void)BtcCoinManagerDidFinishWithPlatforms:(NSArray *)platforms;
- (void)BtcCoinManagerDidFinishWithBtcs:(NSArray *)btcs;

- (void)BtcCoinManagerDidFinishWithSubscibes:(NSArray *)subscibes;
- (void)BtcCoinManagerDeleteDidFinishWithSubscibe:(SubscibeModal *)subscibe;
@end
@interface BtcCoinManager : NSObject
@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSMutableArray *tickers;
@property (nonatomic, retain) NSMutableArray    *subscibes;
+ (BtcCoinManager *)shared;

- (void)addTaskObserver:(id<BtcCoinDelegate>)observer;
- (void)removeTaskObserver:(id<BtcCoinDelegate>)observer;

- (void)initBtcData;
- (void)requestBTCTickers;
- (void)getBTC;

- (BOOL)isSubscibeWithTicker:(NSString *)ticker;
- (void)subscibeWithBtc:(BtcData *)btc;
- (void)unSubscibeWithBtc:(BtcData *)btc;
@end
