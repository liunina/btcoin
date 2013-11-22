//
//  CateViewController.m
//  BtcCoin
//
//  Created by liunian on 13-11-18.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "CateViewController.h"
#import "BtcCoinManager.h"
#import "CateCell.h"

@interface CateViewController ()<UITableViewDataSource,UITableViewDelegate,BtcCoinDelegate>
@property (nonatomic, retain) NSMutableArray *datasource;
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation CateViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        [[BtcCoinManager shared] addTaskObserver:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
    
#else
    float systemName = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(systemName >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        [self.navigationController.navigationBar setBarTintColor:[UIColor flatDarkGreenColor]];
        self.view.bounds = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height);
    }
#endif
    [self.view setBackgroundColor:[UIColor blackColor]];
    [[BtcCoinManager shared] getBTC];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 
- (void)BtcCoinManagerDidFinishWithPlatforms:(NSArray *)platforms{
    self.datasource = [NSMutableArray arrayWithArray:platforms];
    [self.tableView reloadData];
}

#pragma mark
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeightCateCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CateCell *cell = (CateCell *)[tableView cellForRowAtIndexPath:indexPath];
    BtcData *btc = [[[BtcCoinManager shared] tickers] objectAtIndex:indexPath.row];
    if ([[BtcCoinManager shared] isSubscibeWithTicker:btc.ticker]) {
        [[BtcCoinManager shared] unSubscibeWithBtc:btc];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else{
        [[BtcCoinManager shared] subscibeWithBtc:btc];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[BtcCoinManager shared] tickers].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"btc";
    CateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[CateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    BtcData *btc = [[[BtcCoinManager shared] tickers] objectAtIndex:indexPath.row];
    [cell updateWithBtc:btc];
    if ([[BtcCoinManager shared] isSubscibeWithTicker:btc.ticker]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

#pragma mark getter
- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _datasource;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        CGFloat h = CGRectGetHeight(self.view.bounds);
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
            self.view.bounds = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height );
            h = CGRectGetHeight(self.view.bounds) - 20;
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 40, h)
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor flatBlackColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
@end
