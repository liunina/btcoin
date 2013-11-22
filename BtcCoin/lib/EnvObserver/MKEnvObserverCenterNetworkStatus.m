//
//  MKEnvObserverCenterNetworkStatus.m
//  MoKe
//
//  Created by Yan FENG on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKEnvObserverCenterNetworkStatus.h"

static MKEnvObserverCenterNetworkStatus * defaultCenter;

@implementation MKEnvObserverCenterNetworkStatus
+ (MKEnvObserverCenterNetworkStatus *)defaultCenter
{
    if (!defaultCenter) {
        defaultCenter = [[MKEnvObserverCenterNetworkStatus alloc] init];
    }
    return defaultCenter;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:) 
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        
        _host = [[Reachability reachabilityWithHostName:@"www.baidu.com"] retain];
        [_host startNotifier];
        _networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];

    }
    return self;
}

- (void)dealloc
{
    RELEASE_SAFELY(_host);
    [super dealloc];
}

- (NetworkStatus)getCurrentNetworkStatus 
{
    return _networkStatus;
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    NetworkStatus fromStatus = _networkStatus;
    _networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    if (fromStatus == _networkStatus) {
        return;
    }
    
    for (MKObserver * ob in _observersAry) {
        id<MKEnvObserverNetworkStatusProtocol> observer = ob.observer;
        if ([observer respondsToSelector:@selector(mkEnvObserverNetworkStatusDidChangedFromStatus:toStatus:)]) {
            [observer mkEnvObserverNetworkStatusDidChangedFromStatus:fromStatus toStatus:_networkStatus];
        }
    }
}

@end
