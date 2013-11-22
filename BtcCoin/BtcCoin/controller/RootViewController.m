//
//  RootViewController.m
//  BtcCoin
//
//  Created by liunian on 13-11-15.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "RootViewController.h"
#import "BtcCell.h"
#import "BtcCoinManager.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate,BtcCoinDelegate>
@property (nonatomic, retain) NSMutableArray *datasource;
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation RootViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
    
#else
    float systemName = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(systemName >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        [self.navigationController.navigationBar setBarTintColor:[UIColor flatDarkGreenColor]];
    }
#endif
    
    self.title = @"价格走势";
    
    // Navigation bar appearance (background ant title)
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor flatWhiteColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"FontNAme" size:20], NSFontAttributeName, nil]];
    
    [[UINavigationBar appearance] setTintColor:[UIColor flatDarkGreenColor]];
    
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbutton setFrame:CGRectMake(0, 0, 30, 30)];
    [leftbutton setImage:IMGNAMED(@"menu.png") forState:UIControlStateNormal];
    [leftbutton setImage:IMGNAMED(@"menu_1.png") forState:UIControlStateHighlighted];
    [leftbutton addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setFrame:CGRectMake(0, 0, 30, 30)];
    [rightbutton setImage:IMGNAMED(@"clock.png") forState:UIControlStateNormal];
    [rightbutton setImage:IMGNAMED(@"clock_1.png") forState:UIControlStateHighlighted];
    [rightbutton addTarget:self action:@selector(showRight:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:leftbutton];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightbutton];
    
    self.navigationItem.leftBarButtonItem = button;
    self.navigationItem.rightBarButtonItem = rightBarButton;

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[BtcCoinManager shared] requestBTCTickers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLeft:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
        
    }];
}

- (void)showRight:(id)sender{
    [self.mm_drawerController openDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
        
    }];
}

#pragma mark BtcCoinDelegate
- (void)BtcCoinManagerDidFinishWithSubscibeModal:(SubscibeModal *)subscibe{
//    [self.tableView reloadData];
    [[[BtcCoinManager shared] subscibes] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SubscibeModal *modal = obj;
        if ([subscibe.ticker isEqualToString:modal.ticker]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
        
    }];
}

- (void)BtcCoinManagerDidFinishWithSubscibes:(NSArray *)subscibes{
//    [self.tableView reloadData];
}

- (void)BtcCoinManagerDeleteDidFinishWithSubscibe:(SubscibeModal *)subscibe{
    [[[BtcCoinManager shared] subscibes] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SubscibeModal *modal = obj;
        if ([subscibe.ticker isEqualToString:modal.ticker]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
            [self.tableView endUpdates];
        }

    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeightBtcCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[BtcCoinManager shared] subscibes].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"btc";
    BtcCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[BtcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    SubscibeModal *btc = [[[BtcCoinManager shared] subscibes] objectAtIndex:indexPath.row];
    [cell updateWithBtc:btc];
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
