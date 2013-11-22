//
//  MKEnvObserverCenterApplication.m
//  MoKe
//
//  Created by Yan FENG on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MKEnvObserverCenterApplication.h"

static MKEnvObserverCenterApplication * defaultCenter;

@interface MKEnvObserverCenterApplication ()
- (void)appNotification:(NSNotification *)notification;
@end


@implementation MKEnvObserverCenterApplication

+ (MKEnvObserverCenterApplication *)defaultCenter
{
    if (!defaultCenter) {
        defaultCenter = [[MKEnvObserverCenterApplication alloc] init];
    }
    return defaultCenter;
}

- (id)init
{
    self = [super init];
    if (self) {  
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationDidEnterBackgroundNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationWillEnterForegroundNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationDidFinishLaunchingNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationDidBecomeActiveNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationWillResignActiveNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationDidReceiveMemoryWarningNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationWillTerminateNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationSignificantTimeChangeNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationWillChangeStatusBarOrientationNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationStatusBarOrientationUserInfoKey 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationWillChangeStatusBarFrameNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationDidChangeStatusBarFrameNotification 
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(appNotification:) 
                                                     name:UIApplicationStatusBarFrameUserInfoKey 
                                                   object:nil];
    }
    return self;
}

- (void)appNotification:(NSNotification *)notification
{
    NSString * name = [notification name];
    SEL s;
    if ([name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        s = @selector(mkEnvObserverApplicationDidEnterBackground:);
    } else if ([name isEqualToString:UIApplicationWillEnterForegroundNotification]) {
        s = @selector(mkEnvObserverApplicationWillEnterForeground:);
    } else if ([name isEqualToString:UIApplicationDidFinishLaunchingNotification]) {
        s = @selector(mkEnvObserverApplicationDidFinishLaunching:);
    } else if ([name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        s = @selector(mkEnvObserverApplicationDidBecomeActive:);
    } else if ([name isEqualToString:UIApplicationWillResignActiveNotification]) {
        s = @selector(mkEnvObserverApplicationWillResignActive:);
    } else if ([name isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
        s = @selector(mkEnvObserverApplicationDidReceiveMemoryWarning:);
    } else if ([name isEqualToString:UIApplicationWillTerminateNotification]) {
        s = @selector(mkEnvObserverApplicationWillTerminate:);
    } else if ([name isEqualToString:UIApplicationSignificantTimeChangeNotification]) {
        s = @selector(mkEnvObserverApplicationSignificantTimeChange:);
    } else if ([name isEqualToString:UIApplicationWillChangeStatusBarOrientationNotification]) {
        s = @selector(mkEnvObserverApplicationWillChangeStatusBarOrientation:);
    } else if ([name isEqualToString:UIApplicationDidChangeStatusBarOrientationNotification]) {
        s = @selector(mkEnvObserverApplicationDidChangeStatusBarOrientation:);
    } else if ([name isEqualToString:UIApplicationStatusBarOrientationUserInfoKey]) {
        s = @selector(mkEnvObserverApplicationStatusBarOrientationUserInfoKey);
    } else if ([name isEqualToString:UIApplicationWillChangeStatusBarFrameNotification]) {
        s = @selector(mkEnvObserverApplicationWillChangeStatusBarFrame);
    } else if ([name isEqualToString:UIApplicationDidChangeStatusBarFrameNotification]) {
        s = @selector(mkEnvObserverApplicationDidChangeStatusBarFrame);
    } else if ([name isEqualToString:UIApplicationStatusBarFrameUserInfoKey]) {
        s = @selector(mkEnvObserverApplicationStatusBarFrameUserInfoKey);
    } else {
        return;
    }
    for (MKObserver * ob in _observersAry) {
        id<MKEnvObserverApplicationProtocol> observer = ob.observer;
        if ([observer respondsToSelector:s]) {
            [observer performSelector:s withObject:notification];
        }
    }
}

@end
