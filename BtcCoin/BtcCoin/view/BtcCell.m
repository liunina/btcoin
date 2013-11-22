//
//  BtcCell.m
//  BtcCoin
//
//  Created by liunian on 13-11-15.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "BtcCell.h"

@implementation BtcCell

/*
 @property (nonatomic, retain) UILabel *high;
 @property (nonatomic, retain) UILabel *last;
 @property (nonatomic, retain) UILabel *low;
 
 @property (nonatomic, retain) UILabel *sell;
 @property (nonatomic, retain) UILabel *volStr;
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithBtc:(BtcData *)btc{
    [self.name setText:[NSString stringWithFormat:@"< %@ >",btc.name]];
    [self.volLabel setText:[NSString stringWithFormat:@"成交量%@",btc.btcModal.volStr]];
    
    [self.high setText:[NSString stringWithFormat:@"最高价 %@%@",btc.coinSign,btc.btcModal.high]];
    [self.low setText:[NSString stringWithFormat:@"最低价 %@%@",btc.coinSign,btc.btcModal.low]];
    
    [self.last setText:[NSString stringWithFormat:@"最近成交价 %@%@",btc.coinSign,btc.btcModal.last]];
    
    [self.buy setText:[NSString stringWithFormat:@"买一价 %@%@",btc.coinSign,btc.btcModal.buy]];
    [self.sell setText:[NSString stringWithFormat:@"卖一价 %@%@",btc.coinSign,btc.btcModal.sell]];
    [UIView animateWithDuration:.5 animations:^{
        switch (btc.btcModal.trend) {
            case none:
//                [self.last setBackgroundColor:[UIColor clearColor]];
                [self.contentView setBackgroundColor:[UIColor clearColor]];
                break;
            case GoUp:
//                [self.last setBackgroundColor:[Util getColor:@"7CBA6F"]];
//                [self.contentView setBackgroundColor:[Util getColor:@"7CBA6F"]];
//                [self.last setBackgroundColor:[UIColor flatGreenColor]];
                [self.contentView setBackgroundColor:[UIColor flatGreenColor]];
                break;
            case PullDown:
//                [self.last setBackgroundColor:[Util getColor:@"D7454C"]];
//                [self.contentView setBackgroundColor:[Util getColor:@"D7454C"]];
//                [self.last setBackgroundColor:[UIColor flatRedColor]];
                [self.contentView setBackgroundColor:[UIColor flatRedColor]];
                break;
            case Fair:
//                [self.last setBackgroundColor:[Util getColor:@"DCE5C6"]];
                [self.contentView setBackgroundColor:[Util getColor:@"DCE5C6"]];
                break;
            default:
                break;
        }
    } completion:^(BOOL finished) {
        
    }];
    

}

#pragma mark 
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 20)];
        [_name setBackgroundColor:[UIColor clearColor]];
        [_name setFont:FONT_SYSTEM(16)];
        [_name setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_name setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_name];
    }
    return _name;
}



- (UILabel *)last{
    if (!_last) {
        _last = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 250, 20)];
        [_last setBackgroundColor:[UIColor clearColor]];
        [_last setFont:FONT_SYSTEM(16)];
        [_last setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_last setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_last];
    }
    return _last;
}

- (UILabel *)buy{
    if (!_buy) {
        _buy = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 150, 20)];
        [_buy setBackgroundColor:[UIColor clearColor]];
        [_buy setFont:FONT_SYSTEM(16)];
        [_buy setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_buy setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_buy];
    }
    return _buy;
}

- (UILabel *)sell{
    if (!_sell) {
        _sell = [[UILabel alloc] initWithFrame:CGRectMake(170, 40, 150, 20)];
        [_sell setBackgroundColor:[UIColor clearColor]];
        [_sell setFont:[UIFont systemFontOfSize:16]];
        [_sell setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_sell setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_sell];
    }
    return _sell;
}
- (UILabel *)high{
    if (!_high) {
        _high = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 150, 20)];
        [_high setBackgroundColor:[UIColor clearColor]];
        [_high setFont:FONT_SYSTEM(16)];
        [_high setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_high setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_high];
    }
    return _high;
}



- (UILabel *)low{
    if (!_low) {
        _low = [[UILabel alloc] initWithFrame:CGRectMake(170, 60, 150, 20)];
        [_low setBackgroundColor:[UIColor clearColor]];
        [_low setFont:FONT_FZLTHJW(16)];
        [_low setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_low setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_low];
    }
    return _low;
}



- (UILabel *)volLabel{
    if (!_volLabel) {
        _volLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 0, 150, 20)];
        [_volLabel setBackgroundColor:[UIColor clearColor]];
        [_volLabel setFont:FONT_SYSTEM(16)];
        [_volLabel setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_volLabel setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_volLabel];
    }
    return _volLabel;
}

@end
