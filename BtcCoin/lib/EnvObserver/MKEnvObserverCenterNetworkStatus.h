//
//  MKEnvObserverCenterNetworkStatus.h
//  MoKe
//
//  Created by Yan FENG on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKEnvObserverCenter.h"
#import "Reachability.h"

@protocol MKEnvObserverNetworkStatusProtocol <NSObject>
@optional
- (void)mkEnvObserverNetworkStatusDidChangedFromStatus:(NetworkStatus)fromStatus toStatus:(NetworkStatus)toStatus;
@end

@interface MKEnvObserverCenterNetworkStatus : MKEnvObserverCenter {
    Reachability * _host;
    NetworkStatus _networkStatus;
}
+ (MKEnvObserverCenterNetworkStatus *)defaultCenter;
- (NetworkStatus)getCurrentNetworkStatus;
@end
