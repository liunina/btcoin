//
//  AppDelegate.m
//  BtcCoin
//
//  Created by liunian on 13-11-14.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "AppDelegate.h"
#import "BtcCoinManager.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)loadLocalData{
    NSString *storeFilePath = [MKDocumentDir  stringByAppendingPathComponent:@"BtcCoin.sqlite"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:storeFilePath]) {
        
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BtcCoin.sqlite"];
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"BtcCoin" withExtension:@"sqlite"];
        NSError *error = nil;
        [[NSFileManager defaultManager] copyItemAtURL:fileURL toURL:storeURL error:&error];
        if (error) {
            BMLog(@"创建失败");
        }else{
            BMLog(@"创建成功");
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*
     http://www.btc123.com/e/interfaces/tickers.php?type=btcchinaTicker&suffix=0.7166526638902724
     http://www.btc123.com/e/interfaces/tickers.php?type=MtGoxTicker&suffix=0.8309319806285203
     http://www.btc123.com/e/interfaces/tickers.php?type=btctradeTicker&suffix=0.5935922747012228
     
     http://www.btc123.com/e/interfaces/tickers.php?type=bitstampTicker&suffix=0.18868565442971885
     http://www.btc123.com/e/interfaces/tickers.php?type=fxbtcTicker&suffix=0.4042526204138994
     http://www.btc123.com/e/interfaces/tickers.php?type=huobiTicker&suffix=0.8465060179587454
     http://www.btc123.com/e/interfaces/tickers.php?type=btc100Ticker&suffix=0.5583217623643577
     http://www.btc123.com/e/interfaces/tickers.php?type=796futuresTicker&suffix=0.8552239949349314
     http://www.btc123.com/e/interfaces/tickers.php?type=chbtcTicker&suffix=0.0885342878755182
     
     http://www.btc123.com/e/interfaces/tickers.php?type=fxbtcLTCCNYticker&suffix=0.71978639671579
     
     http://www.btc123.com/e/interfaces/tickers.php?type=okcoinTicker&suffix=0.15787334204651415
     
     */
    [self loadLocalData];
    [[BtcCoinManager shared] setManagedObjectContext:self.managedObjectContext];
    [[BtcCoinManager shared] initBtcData];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navigation
                                                                           leftDrawerViewController:self.cateViewController
                                                                          rightDrawerViewController:self.clockViewController];
    self.drawerController = drawerController;
    [self.drawerController setMaximumLeftDrawerWidth:CGRectGetWidth([[UIScreen mainScreen] bounds]) - 40];
    [self.drawerController setMaximumRightDrawerWidth:CGRectGetWidth([[UIScreen mainScreen] bounds]) - 40];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeParallax];
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeSlide];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.drawerController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BtcCoin" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BtcCoin.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark
- (RootViewController *)rootViewController{
    if (!_rootViewController) {
        _rootViewController = [[RootViewController alloc] init];
    }
    return _rootViewController;
}

- (CateViewController *)cateViewController{
    if (!_cateViewController) {
        _cateViewController = [[CateViewController alloc] init];
    }
    return _cateViewController;
}

- (ClockViewController *)clockViewController{
    if (!_clockViewController) {
        _clockViewController = [[ClockViewController alloc] init];
    }
    return _clockViewController;
}
@end
