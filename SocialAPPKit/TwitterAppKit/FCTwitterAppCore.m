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
#import "NSString+FCString.h"
#import "NSDictionary+FCDictionary.h"

#define TwitterAuthTokenUrl  @"https://api.twitter.com/oauth/request_token"
#define TwitterAccessTokenUrl  @"https://api.twitter.com/oauth/access_token"
#define TwitterWebUrl(auth_token) [NSString stringWithFormat:@"https://api.twitter.com/oauth/authenticate?oauth_token=%@", auth_token]

@interface FCTwitterAppCore ()

@property (nonatomic, copy) FCTwitterAppConfig *appConfig;

@property (nonatomic, copy) NSString *signKey;

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
    [[self requestAuthToken] subscriberSuccess:^(id x) {
        NSLog(@"1");
    } error:^(NSError *error) {
        NSLog(@"1");
    }];
}

- (void)authWithNative {
    
}

- (FCCallBack *)requestAuthToken {
    FCBaseRequest *api = [FCBaseRequest new];
    api.absoluteUrl = TwitterAuthTokenUrl;
    api.httpMethod = FCHttpMethodPOST;
    NSMutableDictionary *paramters = [self apiBaseParamters];
    NSString *signBody = [api.absoluteUrl twitter_signBodyWithParamter:paramters];
    paramters[@"oauth_signature"] = [self.signKey twitter_signStrWithSignBody:signBody];
    NSString *header = [NSString twitter_authEncodeWithParamter:paramters];
    api.httpHeader = @{@"Authorization":header};
    return [api startRequest];
}

- (FCCallBack *)displayWebView {
    FCWebViewController *webController = [FCWebViewController new];
    return webController.callBack;
}

- (void)requestAccessToken {
    FCBaseRequest *api = [FCBaseRequest new];
    api.absoluteUrl = TwitterAccessTokenUrl;
    
    [[api startRequest] subscriberSuccess:^(id x) {
        
    } error:^(NSError *error) {
        
    }];
}

- (NSMutableDictionary *)apiBaseParamters {
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"oauth_version"] = @"1.0";
    paramters[@"oauth_signature_method"] = @"HMAC-SHA1";
    paramters[@"oauth_consumer_key"] = self.appConfig.appKey;
    paramters[@"oauth_callback"] = self.appConfig.redirectUrl;
    paramters[@"oauth_timestamp"] = @((int)[[NSDate date] timeIntervalSince1970]);
//    @"1525311506";
    paramters[@"oauth_nonce"] = [[NSUUID UUID] UUIDString];
//    @"EA551ED6-D05F-412A-8030-17AB9A925354";
    
    return paramters;
}

- (NSString *)signKey {
    return [self.appConfig.appSecret stringByAppendingString:@"&"];
}

@end

