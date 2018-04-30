//
//  FCTwitterAppCore.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/26.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCTwitterAppCore.h"
#import "FCWebViewController.h"
#import "FCTwitterAppConfig.h"
#import "FCCallBack.h"

@interface FCTwitterAppCore ()

@property (nonatomic, strong) FCCallBack *authCallBack;

@property (nonatomic, copy) FCTwitterAppConfig *appConfig;

@end

@implementation FCTwitterAppCore

static NSString *authTokenUrl = @"https://api.twitter.com/oauth/request_token";
static NSString *accessTokenUrl = @"https://api.twitter.com/oauth/access_token";
static NSString *webUrl = @"https://api.twitter.com/oauth/authenticate?oauth_token";

- (instancetype)initWithConfigModel: (FCTwitterAppConfig *)appConfig {
    self = [super init];
    if (self) {
        _authCallBack = [FCCallBack new];
        _appConfig = appConfig;
    }
    return self;
}

- (void)authWithWeb {
    
}

- (void)authWithNative {
    
}

- (FCCallBack *)startAuth {
    if (!_appConfig) {
        [self.authCallBack delaySendError:[FCError errorWithMessage:@"lack of configuration"]];
        return self.authCallBack;
    }
    if ([self isCanOpenTwitter])
        [self authWithNative];
    else
        [self authWithWeb];
    return self.authCallBack;
}

- (BOOL)isCanOpenTwitter {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[self titterOpenUrl]]];
}

- (NSString *)titterOpenUrl {
    return [NSString stringWithFormat:@"twitterauth://authorize?consumer_key=%@&consumer_secret=%@&oauth_callback=twitterkit-%@", self.appConfig.appKey, self.appConfig.appSecret, self.appConfig.redirectUrl];
}

@end
