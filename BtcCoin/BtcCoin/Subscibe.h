//
//  Subscibe.h
//  BtcCoin
//
//  Created by liunian on 13-11-18.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Subscibe : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * ticker;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSNumber * index;

@end
