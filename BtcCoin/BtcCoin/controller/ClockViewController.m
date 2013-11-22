//
//  ClockViewController.m
//  BtcCoin
//
//  Created by liunian on 13-11-18.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()

@end

@implementation ClockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.view.bounds = CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height );
    }
#endif
    [self.view setBackgroundColor:[UIColor flatDarkGreenColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
