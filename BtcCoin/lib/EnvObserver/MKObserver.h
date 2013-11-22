//
//  MKObserver.h
//  MoKe
//
//  Created by Yan FENG on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// 用于保存observer的object instance，但是不retain
#import <Foundation/Foundation.h>

@interface MKObserver : NSObject {
    id _observer;
}

@property (nonatomic,assign) id observer;

+ (id)createWithObejct:(id)obejct;
- (id)initWithObject:(id)object;

- (void)noticeOberver:(SEL)selector;
- (void)noticeOberver:(SEL)selector withObject:(id)object;
- (void)noticeOberver:(SEL)selector withObject:(id)object1 withObject:(id)object2;

@end
