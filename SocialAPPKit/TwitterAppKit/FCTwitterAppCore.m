//
//  FCTwitterAppCore.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/26.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCTwitterAppCore.h"
#import "FCWebViewController.h"
#import "FCWebViewController.h"
#import "FCTwitterAppConfig.h"
#import "FCTwitterAppSession.h"
#import "FCBaseRequest.h"
#import "FCCallBack.h"
#import "FCCategory.h"
#import "NSString+FCString.h"
#import "NSDictionary+FCDictionary.h"

#define FCWeakSelf  __weak typeof(self) WeakSelf = self;
#define FCStrongSelf  __strong typeof(self) self = WeakSelf;

#define TwitterAuthTokenUrl  @"https://api.twitter.com/oauth/request_token"
#define TwitterAccessTokenUrl  @"https://api.twitter.com/oauth/access_token"
#define TwitterSessionVerifyUrl @"https://api.twitter.com/1.1/account/verify_credentials.json"
#define TwitterWebUrl(auth_token) [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", auth_token]

@interface FCTwitterAppCore ()

@property (nonatomic, copy) FCTwitterAppConfig *appConfig;

@property (nonatomic, weak) FCWebViewController *webController;

@property (nonatomic, copy) NSString *authSecret;

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
    [[self requestAuthToken] subscriberSuccess:^(NSData *data) {
        NSDictionary *responseDic = [data twitter_responseDataMap];
        if ([responseDic.allKeys containsObject:@"error"]) {
            FCError *customError = [FCError errorWithCode:-1 userInfo:responseDic];
            [self.authCallBack sendError:customError];
        } else {
            NSString *requestToken = responseDic[@"oauth_token"];
            [[self requestWebLogin:requestToken] subscriberSuccess:^(NSString *redirectParamterStr) {
                NSDictionary *paramter = [redirectParamterStr urlPathFormatTransformMap];
                [self.webController dismissViewControllerAnimated:YES completion:nil];
                [self requestAccessToken:paramter[@"oauth_token"] verify:paramter[@"oauth_verifier"]];
            } error:^(NSError *error) {
                [self.authCallBack sendError:error];
            }];
        }
    } error:^(NSError *error) {
        [self.authCallBack sendError:error];
    }];
}

- (void)authWithDeepLink {
    [[UIApplication sharedApplication] openURL:self.twitterOpenUrl options:@{} completionHandler:nil];
}

- (void)deeplinkURLDataMap: (NSURL *)deeplinkURL {
    if (!deeplinkURL.query.length) {
        FCError *error = [FCError errorWithMessage:@"用户取消授权"];
        [self.authCallBack sendError:error];
        return;
    }
    NSDictionary *responseDic = [deeplinkURL.query urlPathFormatTransformMap];
    FCTwitterAppSession *session = [FCTwitterAppSession initWithAuthToken:responseDic[@"token"] secret:responseDic[@"secret"] userID:nil userName:responseDic[@"username"]];
    if (_isNeedUserID) {
        [self requestUserSession:session];
        return;
    }
    [self.authCallBack sendSuccess:session];
}

#pragma mark Private authRequest
- (FCCallBack *)requestAuthToken {
    FCBaseRequest *api = [self baseRequestApi:TwitterAuthTokenUrl paramters:nil httpMethod:FCHttpMethodPOST];
    return [api startRequest];
}

- (FCCallBack *)requestWebLogin: (NSString *)requestToken {
    FCWebViewController *webController = [FCWebViewController new];
    webController.webURLString = TwitterWebUrl(requestToken);
    webController.socialType = FCSocialWebTypeTwitter;
    webController.callBackKey = self.appConfig.redirectUrl.length ? self.appConfig.redirectUrl : @"oauth_verifier";
    [webController showWebController];
    self.webController = webController;
    return webController.callBack;
}

- (void)requestAccessToken: (NSString *)token verify: (NSString *)verifier {
    NSAssert(verifier.length && token.length, @"web页面参数丢失");
    NSDictionary *paramters = @{@"oauth_verifier":verifier,
                                @"oauth_token":token};
    FCBaseRequest *api = [self baseRequestApi:TwitterAccessTokenUrl paramters:paramters httpMethod:FCHttpMethodPOST];
    [[api startRequest] subscriberSuccess:^(NSData *data) {
        NSDictionary *responseDic = [data twitter_responseDataMap];
        if ([responseDic.allKeys containsObject:@"error"]) {
            FCError *customError = [FCError errorWithCode:-1 userInfo:responseDic];
            [self.authCallBack sendError:customError];
        } else {
            FCTwitterAppSession *session = [FCTwitterAppSession initWithAuthToken:responseDic[@"oauth_token"] secret:responseDic[@"oauth_token_secret"] userID:responseDic[@"user_id"] userName:responseDic[@"screen_name"]];
            [self.authCallBack sendSuccess:session];
        }
    } error:^(NSError *error) {
        [self.authCallBack sendError:error];
    }];
}

- (void)requestUserSession: (FCTwitterAppSession *)userSession {
    NSAssert(userSession.auth_Token.length, @"deeplink参数缺失");
    NSDictionary *paramters = @{@"oauth_token":userSession.auth_Token};
    self.authSecret = userSession.auth_Secret;
    FCBaseRequest *api = [self baseRequestApi:TwitterSessionVerifyUrl paramters:paramters httpMethod:FCHttpMethodGET];
    [[api startRequest] subscriberSuccess:^(NSData *data) {
        NSLog(@"1");
    } error:^(NSError *error) {
        NSLog(@"1");
    }];
}

#pragma mark private getApi
- (FCBaseRequest *)baseRequestApi: (NSString *)url paramters: (NSDictionary *)customParamters httpMethod: (FCHttpMethod)method {
    FCBaseRequest *api = [FCBaseRequest new];
    api.absoluteUrl = url;
    api.httpMethod = method;
    NSMutableDictionary *paramters = [self apiBaseParamters];
    [paramters addEntriesFromDictionary:customParamters];
    NSString *signBody = [api.absoluteUrl twitter_signBodyWithParamter:paramters];
    paramters[@"oauth_signature"] = [self.signKey twitter_signStrWithSignBody:signBody];
    NSString *header = [NSString twitter_authEncodeWithParamter:paramters];
    api.httpHeader = @{@"Authorization":header};
    return api;
}

#pragma mark Private httpConfig
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
    NSString *signkey = [self.appConfig.appSecret stringByAppendingFormat:@"&%@", self.authSecret];
    self.authSecret = nil;
    return signkey;
}

#pragma mark getter
- (NSURL *)twitterOpenUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"twitterauth://authorize?consumer_key=%@&consumer_secret=%@&oauth_callback=twitterkit-%@", self.appConfig.appKey, self.appConfig.appSecret, self.appConfig.redirectUrl]];
}

@end
