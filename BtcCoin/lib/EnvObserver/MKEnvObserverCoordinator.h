//
//  MKEnvObserverCoordinator.h
//  MoKe
//
//  Created by Yan FENG on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKEnvObserverCenterApplication.h"
#import "MKEnvObserverCenterNetworkStatus.h"

#define MKAddNetworkStatusObserver(X)       [MKEnvObserverCoordinator addNetworkStatusObserver:X]
#define MKRemoveNetworkStatusObserver(X)    [MKEnvObserverCoordinator removeNetworkStatusObserver:X]
#define MKGetCurrentNetworkStatus           [MKEnvObserverCoordinator getCurrentNetworkStatus]

#define MKAddApplicationObserver(X)         [MKEnvObserverCoordinator addApplicationObserver:X]
#define MKRemoveApplicationObserver(X)      [MKEnvObserverCoordinator removeApplicationObserver:X]

@interface MKEnvObserverCoordinator : NSObject
+ (MKEnvObserverCoordinator *)defaultCoordinator;

+ (void)addNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer;
+ (void)removeNetworkStatusObserver:(id<MKEnvObserverNetworkStatusProtocol>)observer;
+ (NetworkStatus)getCurrentNetworkStatus;

+ (void)addApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer;
+ (void)removeApplicationObserver:(id<MKEnvObserverApplicationProtocol>)observer;

@end
