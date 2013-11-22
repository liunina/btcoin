//
//  MKEnvObserverCenter.h
//  MoKe
//
//  Created by Yan FENG on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKObserver.h"

@interface MKEnvObserverCenter : NSObject {
    NSMutableArray * _observersAry;
}

@property (nonatomic,readonly) NSArray * observers;

- (void)addEnvObserver:(id)observer;
- (void)removeEnvObserver:(id)observer;

- (void)noticeObervers:(SEL)selector;
- (void)noticeObervers:(SEL)selector withObject:(id)object;
- (void)noticeObervers:(SEL)selector withObject:(id)object1 withObject:(id)object2;
@end
