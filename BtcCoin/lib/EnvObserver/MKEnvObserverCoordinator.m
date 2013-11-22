//
//  MKEnvObserverCoordinator.m
//  MoKe
//
//  Created by Yan FENG on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKEnvObserverCoordinator.h"

static MKEnvObserverCoordinator * defaultCoordinator;

@implementation MKEnvObserverCoordinator

+ (MKEnvObserverCoordinator *)defaultCoordinator
{
    if (!defaultCoordinator) {
        defaultCoordinator = [[MKEnvObserverCoordinator alloc] init];
    }
    return defaultCoordinator;
}

+ (void)addNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer
{
    [[MKEnvObserverCenterNetworkStatus defaultCenter] addEnvObserver:observer];
}

+ (void)removeNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer
{
    [[MKEnvObserverCenterNetworkStatus defaultCenter] removeEnvObserver:observer];
}

+ (NetworkStatus)getCurrentNetworkStatus
{
    return [[MKEnvObserverCenterNetworkStatus defaultCenter] getCurrentNetworkStatus];
}

+ (void)addApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer
{
    [[MKEnvObserverCenterApplication defaultCenter] addEnvObserver:observer];
}

+ (void)removeApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer
{
    [[MKEnvObserverCenterApplication defaultCenter] removeEnvObserver:observer];
}

@end
