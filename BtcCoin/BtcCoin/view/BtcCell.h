//
//  BtcCell.h
//  BtcCoin
//
//  Created by liunian on 13-11-15.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtcData.h"

#define kHeightBtcCell  90
@interface BtcCell : UITableViewCell
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *buy;
@property (nonatomic, retain) UILabel *high;
@property (nonatomic, retain) UILabel *last;
@property (nonatomic, retain) UILabel *low;

@property (nonatomic, retain) UILabel *sell;
@property (nonatomic, retain) UILabel *volLabel;

- (void)updateWithBtc:(BtcData *)btc;
@end
