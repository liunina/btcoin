//
//  Platform.h
//  BtcCoin
//
//  Created by liunian on 13-11-18.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Platform : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * ticker;
@property (nonatomic, retain) NSString * link;

@end
