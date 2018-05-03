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

#define FCWeakSelf  __weak typeof(self) WeakSelf = self;
#define FCStrongSelf  __strong typeof(self) self = WeakSelf;

#define TwitterAuthTokenUrl  @"https://api.twitter.com/oauth/request_token"
#define TwitterAccessTokenUrl  @"https://api.twitter.com/oauth/access_token"
#define TwitterWebUrl(auth_token) [NSString stringWithFormat:@"https://api.twitter.com/oauth/authenticate?oauth_token=%@", auth_token]

@interface FCTwitterAppCore ()

@property (nonatomic, copy) FCTwitterAppConfig *appConfig;

@property (nonatomic, copy) NSString *signKey;

@property (nonatomic, copy) NSString *requestToken;

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
    FCWeakSelf
    [[self requestAuthToken] subscriberSuccess:^(NSDictionary *response) {
        FCStrongSelf
        self.requestToken = response[@"oauth_token"];
        [[self displayWebView] subscriberSuccess:^(id x) {
            NSLog(@"1");
        }];
    } error:^(NSError *error) {
        [self.authCallBack sendError:error];
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
    webController.webURLString = TwitterWebUrl(self.requestToken);
    webController.socialType = FCSocialWebTypeTwitter;
    webController.callBackKey = self.appConfig.redirectUrl.length ? self.appConfig.redirectUrl : @"oauth_verifier";
    [webController showWebController];
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
    paramters[@"oauth_nonce"] = [[NSUUID UUID] UUIDString];
    return paramters;
}

- (NSString *)signKey {
    return [self.appConfig.appSecret stringByAppendingString:@"&"];
}

@end
