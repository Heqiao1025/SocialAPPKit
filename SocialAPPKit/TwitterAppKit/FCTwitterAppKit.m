//
//  FCTwitterAppKit.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/20.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCTwitterAppKit.h"
#import "FCTwitterAppConfig.h"
#import "FCTwitterAppCore.h"
#import "FCCategory.h"

@interface FCTwitterAppKit ()

@property (nonatomic, strong) FCTwitterAppConfig *appConfig;

@property (nonatomic, strong) FCTwitterAppCore *twitterManager;

@property (nonatomic, assign) BOOL isQuick;

@end

@implementation FCTwitterAppKit

+ (instancetype)shareInstance {
    static FCTwitterAppKit *twitterKit;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        twitterKit = [self new];
    });
    return twitterKit;
}

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret redirectUrl: (NSString *)redirectUrl {
    self.appConfig = [FCTwitterAppConfig initWithConsumerKey:appkey consumerSecret:appSecret redirectUrl:redirectUrl];
}

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret {
    [self registerAppKey:appkey appSecret:appSecret redirectUrl:nil];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSString *source = options[UIApplicationOpenURLOptionsSourceApplicationKey];
    BOOL isTwitterSource = [source twitter_verifySourceApplication];
    BOOL isSechme = [url.scheme twitter_verifyURLSechme:[self twitterKitURLScheme]];
    if ((isSechme || isTwitterSource)){
        [_twitterManager deeplinkURLDataMap:url];
    }
    return isSechme || isTwitterSource;
}

- (void)logInWithCompletion:(FCTwitterLoginCompletion)LoginCompletion {
    [self startTitterAuth:LoginCompletion];
}

- (void)quickLogInWithCompletion:(FCTwitterLoginCompletion)LoginCompletion {
    self.isQuick = YES;
    [self logInWithCompletion:LoginCompletion];
}

#pragma mark Private
- (void)startTitterAuth:(FCTwitterLoginCompletion)loginCompletion {
    if (![self isAvailableConfig] && loginCompletion) {
        FCError *error = [FCError errorWithMessage:@"lack of configuration"];
        loginCompletion(nil, error);
        return;
    }
    if ([self isCanOpenTwitter])
        [self.twitterManager authWithDeepLink];
    else
        [self.twitterManager authWithWeb];
    self.twitterManager.LoginCompletion = loginCompletion;
}

#pragma mark verify
- (BOOL)isAvailableConfig {
    return self.appConfig.appKey.length && self.appConfig.appSecret.length;
}

- (BOOL)isCanOpenTwitter {
    return [[UIApplication sharedApplication] canOpenURL:self.twitterManager.twitterOpenUrl];
}

#pragma mark getter
- (FCTwitterAppCore *)twitterManager {
    if (!_twitterManager) {
        _twitterManager = [[FCTwitterAppCore alloc] initWithConfigModel:self.appConfig];
        _twitterManager.isNeedUserID = !_isQuick;
    }
    return _twitterManager;
}

- (NSString *)twitterKitURLScheme {
    return [NSString stringWithFormat:@"twitterkit-%@", self.appConfig.appKey];
}

@end
