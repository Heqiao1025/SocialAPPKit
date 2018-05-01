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
#import "FCBaseRequest.h"
#import "FCCallBack.h"
#import "FCWebViewController.h"
#import "NSString+FCTwitterSign.h"
#import "NSDictionary+FCDictionary.h"

#define TwitterAuthTokenUrl  @"https://api.twitter.com/oauth/request_token"
#define TwitterAccessTokenUrl  @"https://api.twitter.com/oauth/access_token"
#define TwitterWebUrl(auth_token) [NSString stringWithFormat:@"https://api.twitter.com/oauth/authenticate?oauth_token=%@", auth_token]

@interface FCTwitterAppCore ()

@property (nonatomic, copy) FCTwitterAppConfig *appConfig;

@end

@implementation FCTwitterAppCore

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

- (FCCallBack *)requestAuthToken {
    FCBaseRequest *api = [FCBaseRequest new];
    api.absoluteUrl = TwitterAuthTokenUrl;
    
    return [api startRequest];
}

- (void)requestAccessToken {
    FCBaseRequest *api = [FCBaseRequest new];
    api.absoluteUrl = TwitterAccessTokenUrl;
    
    [[api startRequest] subscriberSuccess:^(id x) {
        
    } error:^(FCError *error) {
        
    }];
}

- (FCCallBack *)displayWebView {
    FCWebViewController *webController = [FCWebViewController new];
    return webController.callBack;
}


- (NSMutableDictionary *)apiBaseParamters {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"oauth_version"] = @"1.0";
    paramters[@"oauth_signature_method"] = @"HMAC-SHA1";
    paramters[@"oauth_consumer_key"] = self.appConfig.appKey;
    paramters[@"oauth_callback"] = self.appConfig.redirectUrl;
    paramters[@"oauth_timestamp"] = @((int)[[NSDate date] timeIntervalSince1970]);
    paramters[@"oauth_nonce"] = [[NSUUID UUID] UUIDString];
    return paramters;
}

@end
