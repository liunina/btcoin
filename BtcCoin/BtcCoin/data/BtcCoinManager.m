//
//  BtcCoinManager.m
//  BtcCoin
//
//  Created by liunian on 13-11-14.
//  Copyright (c) 2013年 liunian. All rights reserved.
//

#import "BtcCoinManager.h"
#import "MKEnvObserverCoordinator.h"
#import "MKEnvObserverCenter.h"
#import "HttpRequest.h"
#import "ASINetworkQueue.h"
#import "BtcData.h"
#import "Platform.h"
#import "Subscibe.h"

#define kBTCAPI @"http://z.btc123.com/lib/jsonProxyTickerInfo.php"

static BtcCoinManager *staticShared = nil;
@interface BtcCoinManager ()<ASIHTTPRequestDelegate,MKEnvObserverApplicationProtocol>{
    MKEnvObserverCenter *_obCenter;
    ASINetworkQueue *_networkQueue;
}
@property (nonatomic, assign) id<BtcCoinDelegate>delegate;
@property (nonatomic, retain) ASINetworkQueue  *networkQueue;

@end
@implementation BtcCoinManager

- (void)dealloc{
    MKRemoveApplicationObserver(self);
}

#pragma mark - class
- (id)init
{
    self = [super init];
    if (self) {
        _obCenter = [[MKEnvObserverCenter alloc] init];
        MKAddApplicationObserver(self);
    }
    return self;
}

+ (BtcCoinManager *)shared{
    if (nil == staticShared) {
        staticShared = [[BtcCoinManager alloc] init];
    }
    return staticShared;
}
- (void)addTaskObserver:(id<BtcCoinDelegate>)observer{
    [_obCenter addEnvObserver:observer];
}

- (void)removeTaskObserver:(id<BtcCoinDelegate>)observer{
    [_obCenter removeEnvObserver:observer];
}

#pragma mark EnvObserverApplicationProtocol
- (void)envObserverApplicationWillTerminate:(NSNotification *)notification{
    NSError *error;
    if (_managedObjectContext != nil){
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
            NSLog(@"Error: %@,%@",error,[error userInfo]);
        }
    }
}


- (Platform *)platformEntityWithTicker:(NSString *)ticker{
    if (ticker.length <= 0)  return nil;
    NSArray *fetchArray = nil;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Platform"
                                              inManagedObjectContext:self.managedObjectContext];
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"(ticker == %@)", ticker];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setIncludesPendingChanges:YES];
    NSError  *error = nil;
    fetchArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchArray.count > 0) {
        return [fetchArray lastObject];
    }
    return nil;
}

- (void)platform{
    NSArray *fetchArray = nil;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Platform"
                                              inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPendingChanges:YES];
    NSError  *error = nil;
    fetchArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchArray.count > 0) {
        [fetchArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Platform *platform = obj;
            BtcData *btc = [[BtcData alloc] init];
            [btc setName:platform.name];
            [btc setTicker:platform.ticker];
            [btc setLink:platform.link];
            [self.tickers addObject:btc];
            [self insertPlatform:btc];
        }];
    }
}

- (void)insertPlatform:(BtcData *)btc{
    if (nil == btc) {
        return;
    }
    Platform *entity = [self platformEntityWithTicker:btc.ticker];
    if (entity){
        
    }else{
        @synchronized(self){
            Platform *entity = (Platform *)[NSEntityDescription insertNewObjectForEntityForName:@"Platform" inManagedObjectContext:self.managedObjectContext];
            [entity setTicker:btc.ticker];
            [entity setName:btc.name];
            [entity setLink:btc.link];
            NSError *error;
            if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
                NSLog(@"Error: %@,%@",error,[error userInfo]);
            }
        }
    }
}

- (Subscibe *)subscibeEntityWithTicker:(NSString *)ticker{
    if (ticker.length <= 0)  return nil;
    NSArray *fetchArray = nil;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Subscibe"
                                              inManagedObjectContext:self.managedObjectContext];
    
    NSPredicate *predicate;
    predicate = [NSPredicate predicateWithFormat:@"(ticker == %@)", ticker];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setIncludesPendingChanges:YES];
    NSError  *error = nil;
    fetchArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchArray.count > 0) {
        return [fetchArray lastObject];
    }
    return nil;
}

- (void)insertSubscibeModal:(SubscibeModal *)subscibe{
    if (nil == subscibe) {
        return;
    }
    Subscibe *entity = [self subscibeEntityWithTicker:subscibe.ticker];
    if (entity){

    }else{
        @synchronized(self){
            Subscibe *entity = (Subscibe *)[NSEntityDescription insertNewObjectForEntityForName:@"Subscibe" inManagedObjectContext:self.managedObjectContext];
            [entity setTicker:subscibe.ticker];
            [entity setName:subscibe.name];
            [entity setLink:subscibe.link];
            [entity setIndex:[NSNumber numberWithInteger:[self.subscibes count]]];
            NSError *error;
            if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
                NSLog(@"Error: %@,%@",error,[error userInfo]);
            }
        }
    }
}

- (void)deleteSubscibeModal:(SubscibeModal *)subscibe{
    if (nil == subscibe) {
        return;
    }
    Subscibe *entity = [self subscibeEntityWithTicker:subscibe.ticker];
    if (entity){
        if (entity) {
            [self.managedObjectContext deleteObject:entity];
            
            
            [_obCenter noticeObervers:@selector(BtcCoinManagerDeleteDidFinishWithSubscibe:)
                           withObject:subscibe];
        }
        
    }
}
- (void)getSubscibe{
    NSArray *fetchArray = nil;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Subscibe"
                                              inManagedObjectContext:self.managedObjectContext];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index"
                                                                   ascending:NO];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    fetchRequest.fetchLimit = 1000;
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    [fetchRequest setIncludesPendingChanges:YES];
    
    fetchArray = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    _subscibes = [NSMutableArray arrayWithCapacity:fetchArray.count];
    for (Subscibe *object in fetchArray) {
        SubscibeModal *modal = [[SubscibeModal alloc] init];
        [modal setIndex:[object.index integerValue]];
        [modal setName:object.name];
        [modal setLink:object.link];
        [modal setTicker:object.ticker];
        [_subscibes addObject:modal];
    }
//    
//    [_obCenter noticeObervers:@selector(BtcCoinManagerDidFinishWithSubscibes:)
//                   withObject:_subscibes];
}

- (BOOL)isSubscibeWithTicker:(NSString *)ticker{
    if (nil == ticker) {
        return NO;
    }
    Subscibe *entity = [self subscibeEntityWithTicker:ticker];
    return entity ? YES : NO;
}

- (void)subscibeWithBtc:(BtcData *)btc{
    if (btc == nil) {
        return;
    }
    SubscibeModal *modal = [[SubscibeModal alloc] init];
    [modal setName:btc.name];
    [modal setTicker:btc.ticker];
    [modal setBtcModal:btc.btcModal];
    [modal setIndex:[self.subscibes count]];
    [self insertSubscibeModal:modal];
    
    
}
- (void)unSubscibeWithBtc:(BtcData *)btc{

    if (btc == nil) {
        return;
    }

    [self.subscibes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SubscibeModal *modal = obj;
        if ([btc.ticker isEqualToString:modal.ticker]) {
            [self deleteSubscibeModal:modal];
        }
        if (stop) {
            [self getSubscibe];
        }
    }];
    
    
}

- (void)initBtcData{
//    [self platform];
    [self getSubscibe];
//    return;
    NSString *btcData = [[NSBundle mainBundle] pathForResource:@"BtcList" ofType:@"plist"];
    NSArray *list = [NSArray arrayWithContentsOfFile:btcData];

    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        BtcData *btc = [[BtcData alloc] init];
        [btc setName:[dic objectForKey:@"name"]];
        [btc setTicker:[dic objectForKey:@"ticker"]];
        [btc setLink:[dic objectForKey:@"link"]];
        [self.tickers addObject:btc];
        [self insertPlatform:btc];
        
        SubscibeModal *modal = [[SubscibeModal alloc] init];
        [modal setName:btc.name];
        [modal setTicker:btc.ticker];
        [modal setLink:btc.link];
        [modal setIndex:idx];
        
        [self insertSubscibeModal:modal];
        
    }];
}

- (void)getBTC{
    [_obCenter noticeObervers:@selector(BtcCoinManagerDidFinishWithPlatforms:) withObject:self.tickers];
}

- (void)requestBTCTickers{
    for (SubscibeModal *modal in self.subscibes) {
        ASIHTTPRequest *request = [self requestWithBTCTicker:modal.ticker];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:2];
        SET_PARAM(modal, @"btc", params);
        [request setUserInfo:params];
        [self.networkQueue addOperation:request];
    }
    [self.networkQueue go];
}
- (NSString *)pathWithBTCTicker:(NSString *)tickerType{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask ,YES) objectAtIndex: 0 ];
    path =[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.php",tickerType]];
    return path;
}

- (ASIHTTPRequest *)requestWithBTCTicker:(NSString *)tickerType{

    NSString *apiURL = [NSString stringWithFormat:@"%@?type=%@&suffix=0.12706584576517344",kBTCAPI,tickerType];
    NSURL *url = [ NSURL URLWithString:apiURL];
    ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL:url];
    [request setDownloadDestinationPath:[self pathWithBTCTicker:tickerType]];
    [request setShouldContinueWhenAppEntersBackground:YES];
    [request setTimeOutSeconds:20];
    [request setNumberOfTimesToRetryOnTimeout:3];
    [request setDelegate:self];
//    [request startAsynchronous];
    return request;
}

#pragma mark ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request{
    if (request.userInfo == nil) {
        return;
    }
    NSDictionary *userInfo = request.userInfo;
    SubscibeModal *btc = [userInfo objectForKey:@"btc"];
    NSData *elementsData = [NSData dataWithContentsOfFile:[self pathWithBTCTicker:btc.ticker]];
    
    NSError *anError = nil;
    NSDictionary *parsedElements = [NSJSONSerialization JSONObjectWithData:elementsData
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&anError];
    
    BMLog(@"userInfo:%@",userInfo);
    BMLog(@"btc.ticker:%@",btc.ticker);
    BMLog(@"parsedElements:%@",parsedElements);
    
    
    BtcModal *modal = nil;
    if (btc.btcModal) {
        modal = btc.btcModal;
    }else{
        modal = [[BtcModal alloc] init];
    }
    
    if ([btc.ticker isEqualToString:@"MtGoxTicker"]) {
        /*
         data =     {
         avg =         {
         currency = USD;
         display = "$429.44";
         "display_short" = "$429.44";
         value = "429.44312";
         "value_int" = 42944312;
         };
         buy =         {
         currency = USD;
         display = "$433.00";
         "display_short" = "$433.00";
         value = "433.00000";
         "value_int" = 43300000;
         };
         high =         {
         currency = USD;
         display = "$443.95";
         "display_short" = "$443.95";
         value = "443.94998";
         "value_int" = 44394998;
         };
         item = BTC;
         last =         {
         currency = USD;
         display = "$433.00";
         "display_short" = "$433.00";
         value = "433.00000";
         "value_int" = 43300000;
         };
         "last_all" =         {
         currency = USD;
         display = "$433.00";
         "display_short" = "$433.00";
         value = "433.00000";
         "value_int" = 43300000;
         };
         "last_local" =         {
         currency = USD;
         display = "$433.00";
         "display_short" = "$433.00";
         value = "433.00000";
         "value_int" = 43300000;
         };
         "last_orig" =         {
         currency = USD;
         display = "$433.00";
         "display_short" = "$433.00";
         value = "433.00000";
         "value_int" = 43300000;
         };
         low =         {
         currency = USD;
         display = "$406.00";
         "display_short" = "$406.00";
         value = "406.00000";
         "value_int" = 40600000;
         };
         now = 1384498297743239;
         sell =         {
         currency = USD;
         display = "$435.83";
         "display_short" = "$435.83";
         value = "435.82589";
         "value_int" = 43582589;
         };
         vol =         {
         currency = BTC;
         display = "21,009.04\U00a0BTC";
         "display_short" = "21,009.04\U00a0BTC";
         value = "21009.04307249";
         "value_int" = 2100904307249;
         };
         vwap =         {
         currency = USD;
         display = "$430.51";
         "display_short" = "$430.51";
         value = "430.50800";
         "value_int" = 43050800;
         };
         };
         result = success;
         */
        
        NSDictionary *data = [parsedElements objectForKey:@"data"];
        
        NSDictionary *buy = [data objectForKey:@"buy"];
        
        NSDictionary *high = [data objectForKey:@"high"];
        NSDictionary *low = [data objectForKey:@"low"];
        
        NSDictionary *last_all = [data objectForKey:@"last_all"];
        
        NSDictionary *sell = [data objectForKey:@"sell"];
        NSDictionary *vol = [data objectForKey:@"vol"];
        
        
        [modal setBuy:[buy objectForKey:@"value"]];
        [modal setHigh:[high objectForKey:@"value"]];
        [modal setLast:[last_all objectForKey:@"value"]];
        [modal setLow:[low objectForKey:@"value"]];
        [modal setSell:[sell objectForKey:@"value"]];
        [modal setVolStr:[vol objectForKey:@"value"]];
        
        [btc setBtcModal:modal];
    }else if ([btc.ticker isEqualToString:@"btcchinaTicker"]){
        /*
         ticker =     {
         buy = "2653.11";
         high = "2681.81";
         last = "2653.00";
         low = "2599.00";
         sell = "2653.35";
         vol = "40979.42400000";
         };
         */
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"buy"]];
        [modal setHigh:[ticker objectForKey:@"high"]];
        [modal setLast:[ticker objectForKey:@"last"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"sell"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
        
    }else if ([btc.ticker isEqualToString:@"okcoinTicker"]){
        /*
         ticker =     {
         buy = "2635.0";
         high = "2671.0";
         last = "2638.2136";
         low = "2557.0";
         sell = "2638.9";
         vol = "24587.686";
         };
         */
        //==================================================
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"buy"]];
        [modal setHigh:[ticker objectForKey:@"high"]];
        [modal setLast:[ticker objectForKey:@"last"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"sell"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
        
    }else if ([btc.ticker isEqualToString:@"btctradeTicker"]){
        /*
         buy = "2641.00";
         high = 2676;
         last = 2641;
         low = 2543;
         sell = "2641.50";
         vol = "7164.48";
         */
        //122121212121========================================
        

        [modal setBuy:[parsedElements objectForKey:@"buy"]];
        [modal setHigh:[[parsedElements objectForKey:@"high"] stringValue]];
        [modal setLast:[parsedElements objectForKey:@"last"]];
        [modal setLow:[[parsedElements objectForKey:@"low"] stringValue]];
        [modal setSell:[parsedElements objectForKey:@"sell"]];
        [modal setVolStr:[parsedElements objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
        
    }else if ([btc.ticker isEqualToString:@"bitstampTicker"]){
        /*
         ask = "415.80";
         bid = "415.76";
         high = "421.97";
         last = "415.76";
         low = "394.00";
         timestamp = 1384498311;
         volume = "27093.27735940";
         */
        
        [modal setBuy:[parsedElements objectForKey:@"ask"]];
        [modal setHigh:[parsedElements objectForKey:@"high"]];
        [modal setLast:[parsedElements objectForKey:@"last"]];
        [modal setLow:[parsedElements objectForKey:@"low"]];
        [modal setSell:[parsedElements objectForKey:@"bid"]];
        [modal setVolStr:[parsedElements objectForKey:@"volume"]];
        
        [btc setBtcModal:modal];
        
    }else if ([btc.ticker isEqualToString:@"fxbtcTicker"]){
        /*
         params =     {
         symbol = "btc_cny";
         };
         result = 1;
         ticker =     {
         ask = "2648.77";
         bid = 2645;
         high = 2688;
         "last_rate" = "2640.9";
         low = "2562.22";
         vol = "23766.707373758";
         };
         */
        
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"ask"]];
        [modal setHigh:[[ticker objectForKey:@"high"] stringValue]];
        [modal setLast:[ticker objectForKey:@"last_rate"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"bid"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
        
    }else if ([btc.ticker isEqualToString:@"huobiTicker"]){
        /*
         ticker =     {
         buy = "2642.1";
         high = "2663.1";
         last = "2642.1";
         low = "2605.001";
         sell = "2642.1";
         vol = "23710.7315";
         };
         */
        //==================================================
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"buy"]];
        [modal setHigh:[ticker objectForKey:@"high"]];
        [modal setLast:[ticker objectForKey:@"last"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"sell"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
        
    }else if ([btc.ticker isEqualToString:@"btc100Ticker"]){
        /*
         ticker =     {
         buy = "2640.100";
         high = "2681.000";
         last = "2645.000";
         low = "2600.000";
         sell = "2650.000";
         vol = "14148.148";
         };
         */
        //===========================================
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"buy"]];
        [modal setHigh:[ticker objectForKey:@"high"]];
        [modal setLast:[ticker objectForKey:@"last"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"sell"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
    }else if ([btc.ticker isEqualToString:@"796futuresTicker"]){
        /*
         ticker =     {
         buy = "446.51";
         high = "467.90";
         last = "446.90";
         low = "422.22";
         sell = "446.90";
         vol = "15719.86";
         };
         */
        
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"buy"]];
        [modal setHigh:[ticker objectForKey:@"high"]];
        [modal setLast:[ticker objectForKey:@"last"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"sell"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
        
    }else if ([btc.ticker isEqualToString:@"chbtcTicker"]){
        /*
         ticker =     {
         buy = "2643.00";
         high = "2668.0";
         last = "2643.0";
         low = "2549.0";
         sell = "2643.50";
         vol = "30287.322";
         };
         */
        
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"buy"]];
        [modal setHigh:[ticker objectForKey:@"high"]];
        [modal setLast:[ticker objectForKey:@"last"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"sell"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
    }else if ([btc.ticker isEqualToString:@"fxbtcLTCCNYticker"]){
        /*
         params =     {
         symbol = "ltc_cny";
         };
         result = 1;
         ticker =     {
         ask = "26.97";
         bid = "26.8888";
         high = "27.23";
         "last_rate" = "26.8888";
         low = "26.52";
         vol = "155443.63692854";
         };
         */
        
        NSDictionary *ticker = [parsedElements objectForKey:@"ticker"];
        
        [modal setBuy:[ticker objectForKey:@"ask"]];
        [modal setHigh:[ticker objectForKey:@"high"]];
        [modal setLast:[ticker objectForKey:@"last_rate"]];
        [modal setLow:[ticker objectForKey:@"low"]];
        [modal setSell:[ticker objectForKey:@"bid"]];
        [modal setVolStr:[ticker objectForKey:@"vol"]];
        
        [btc setBtcModal:modal];
    }
    
    [_obCenter noticeObervers:@selector(BtcCoinManagerDidFinishWithSubscibeModal:) withObject:btc];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    BMLog(@"requestFailed");
}

#pragma mark getter
- (void)singleDownLoadFail:(ASIHTTPRequest *)request{
    BMLog(@"singleDownLoadFail:%@",request.userInfo);
}
- (void)singleDownloadFinished:(ASIHTTPRequest *)request{
    BMLog(@"singleDownloadFinished:%@",request.userInfo);
}

- (void)singleDownLoadStart:(ASIHTTPRequest *)request{
    BMLog(@"singleDownLoadStart:%@",request.userInfo);
}

- (void)downLoadFinish{
    BMLog(@"downLoadFinish");
    self.networkQueue = nil;
    [self performSelector:@selector(requestBTCTickers) withObject:nil afterDelay:5];
}

#pragma mark getter
- (ASINetworkQueue *)networkQueue{
    if (!_networkQueue) {
        _networkQueue = [[ASINetworkQueue alloc] init];
        [_networkQueue setShouldCancelAllRequestsOnFailure:NO];
        
        [_networkQueue setRequestDidFailSelector:@selector(singleDownLoadFail:)];
        [_networkQueue setRequestDidFinishSelector:@selector(singleDownloadFinished:)];
        [_networkQueue setRequestDidStartSelector:@selector(singleDownLoadStart:)];
        [_networkQueue setQueueDidFinishSelector:@selector(downLoadFinish)];
        
        [_networkQueue setDelegate:self];
        [_networkQueue setMaxConcurrentOperationCount:10];
    }
    return _networkQueue;
}


- (NSMutableArray *)tickers{
    if (!_tickers) {
        _tickers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _tickers;
}

- (NSMutableArray *)subscibes{
    if (!_subscibes) {
        _subscibes = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _subscibes;
}
@end
