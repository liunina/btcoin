//
//  MKEnvObserverCenterApplication.h
//  MoKe
//
//  Created by Yan FENG on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKEnvObserverCenter.h"
@protocol MKEnvObserverApplicationProtocol <NSObject>
@optional
- (void)mkEnvObserverApplicationDidEnterBackground:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillEnterForeground:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidFinishLaunching:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidBecomeActive:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillResignActive:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidReceiveMemoryWarning:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillTerminate:(NSNotification *)notification;
- (void)mkEnvObserverApplicationSignificantTimeChange:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillChangeStatusBarOrientation:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidChangeStatusBarOrientation:(NSNotification *)notification;
- (void)mkEnvObserverApplicationStatusBarOrientationUserInfoKey:(NSNotification *)notification;
- (void)mkEnvObserverApplicationWillChangeStatusBarFrame:(NSNotification *)notification;
- (void)mkEnvObserverApplicationDidChangeStatusBarFrame:(NSNotification *)notification;
- (void)mkEnvObserverApplicationStatusBarFrameUserInfoKey:(NSNotification *)notification;

@end

@interface MKEnvObserverCenterApplication : MKEnvObserverCenter
+ (MKEnvObserverCenterApplication *)defaultCenter;
@end
