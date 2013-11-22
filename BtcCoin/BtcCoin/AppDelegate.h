//
//  AppDelegate.h
//  BtcCoin
//
//  Created by liunian on 13-11-14.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "CateViewController.h"
#import "RootViewController.h"
#import "ClockViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) RootViewController *rootViewController;
@property (strong, nonatomic) CateViewController *cateViewController;
@property (strong, nonatomic) ClockViewController *clockViewController;
@property (strong, nonatomic) MMDrawerController *drawerController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
