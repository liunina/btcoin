//
//  CateCell.h
//  BtcCoin
//
//  Created by liunian on 13-11-18.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtcData.h"

#define kHeightCateCell 50
@interface CateCell : UITableViewCell
@property (nonatomic, retain) UILabel *name;
@property (nonatomic, retain) UILabel *link;
- (void)updateWithBtc:(BtcData *)btc;;
@end
