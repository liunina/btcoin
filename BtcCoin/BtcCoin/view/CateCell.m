//
//  CateCell.m
//  BtcCoin
//
//  Created by liunian on 13-11-18.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "CateCell.h"

@implementation CateCell

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
    [self.name setText:btc.name];
//    [self.link setText:btc.link];
}
#pragma mark
- (UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        [_name setBackgroundColor:[UIColor clearColor]];
        [_name setFont:FONT_SYSTEM(18)];
        [_name setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_name setTextColor:[UIColor darkTextColor]];
        [self.contentView addSubview:_name];
    }
    return _name;
}

- (UILabel *)link{
    if (!_link) {
        _link = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 200, 20)];
        [_link setBackgroundColor:[UIColor clearColor]];
        [_link setFont:FONT_SYSTEM(14)];
        [_link setLineBreakMode:NSUILineBreakModeCharacterWrap];
        [_link setTextColor:[UIColor flatGrayColor]];
        [self.contentView addSubview:_link];
    }
    return _link;
}
@end
