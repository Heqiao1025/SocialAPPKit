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
#import "FCTwitterAppSession.h"
#import "FCBaseRequest.h"
#import "FCError.h"
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

- (instancetype)initWithConfigModel:(FCTwitterAppConfig *)appConfig {
    self = [super init];
    if (self) {
        _appConfig = appConfig;
    }
    return self;
}

- (void)authWithWeb {
    [self requestAuthTokenWithRequestCallBack:^(NSData *response, NSError *error) {
        NSDictionary *responseDic = [response twitter_responseDataMap];
        if ([responseDic.allKeys containsObject:@"error"]) {
            FCError *customError = [FCError errorWithCode:-1 userInfo:responseDic];
            [self loginCompletionCallBackWithSession:nil error:customError];
        } else if (error) {
            [self loginCompletionCallBackWithSession:nil error:error];
        } else {
            NSString *requestToken = responseDic[@"oauth_token"];
            [self requestWebLogin:requestToken webCallBack:^(id response, NSError *error) {
                if (error) {
                    [self loginCompletionCallBackWithSession:nil error:error];
                } else if (![response isKindOfClass:[NSString class]]) {
                    FCError *customError = [FCError errorWithMessage:@"web登录格式错误"];
                    [self loginCompletionCallBackWithSession:nil error:customError];
                } else {
                    NSString *redirectParamterStr = (NSString *)response;
                    NSDictionary *paramter = [redirectParamterStr urlPathFormatTransformMap];
                    [self.webController dismissViewControllerAnimated:YES completion:nil];
                    [self requestAccessToken:paramter[@"oauth_token"] verify:paramter[@"oauth_verifier"]];
                }
            }];
        }
    }];
}

- (void)authWithDeepLink {
    [[UIApplication sharedApplication] openURL:self.twitterOpenUrl options:@{} completionHandler:nil];
}

- (void)deeplinkURLDataMap: (NSURL *)deeplinkURL {
    if (!deeplinkURL.host.length) {
        FCError *error = [FCError errorWithMessage:@"用户取消授权"];
        [self loginCompletionCallBackWithSession:nil error:error];
        return;
    }
    NSDictionary *responseDic = [deeplinkURL.host urlPathFormatTransformMap];
    FCTwitterAppSession *session = [FCTwitterAppSession initWithAuthToken:responseDic[@"token"] secret:responseDic[@"secret"] userID:nil userName:responseDic[@"username"]];
    if (_isNeedUserID) {
        [self requestUserSession:session];
        return;
    }
    [self loginCompletionCallBackWithSession:session error:nil];
}

#pragma mark Private authRequest
- (void)requestAuthTokenWithRequestCallBack:(RequestCallBack)callBack {
    FCBaseRequest *api = [self baseRequestApi:TwitterAuthTokenUrl paramters:nil httpMethod:FCHttpMethodPOST];
    [api startRequest:callBack];
}

- (void)requestWebLogin:(NSString *)requestToken webCallBack:(WebCallBack)callback {
    FCWebViewController *webController = [FCWebViewController new];
    webController.webURLString = TwitterWebUrl(requestToken);
    webController.socialType = FCSocialWebTypeTwitter;
    webController.callBackKey = self.appConfig.redirectUrl.length ? self.appConfig.redirectUrl : @"oauth_verifier";
    [webController showWebController];
    webController.callBack = callback;
    self.webController = webController;
}

- (void)requestAccessToken:(NSString *)token verify:(NSString *)verifier {
    NSAssert(verifier.length && token.length, @"web页面参数丢失");
    NSDictionary *paramters = @{@"oauth_verifier":verifier,
                                @"oauth_token":token};
    FCBaseRequest *api = [self baseRequestApi:TwitterAccessTokenUrl paramters:paramters httpMethod:FCHttpMethodPOST];
    [api startRequest:^(NSData *response, NSError *error) {
        NSDictionary *responseDic = [response twitter_responseDataMap];
        if ([responseDic.allKeys containsObject:@"error"]) {
            FCError *customError = [FCError errorWithCode:-1 userInfo:responseDic];
            [self loginCompletionCallBackWithSession:nil error:customError];
        } else if (error) {
            [self loginCompletionCallBackWithSession:nil error:error];
        } else {
            FCTwitterAppSession *session = [FCTwitterAppSession initWithAuthToken:responseDic[@"oauth_token"] secret:responseDic[@"oauth_token_secret"] userID:responseDic[@"user_id"] userName:responseDic[@"screen_name"]];
            [self loginCompletionCallBackWithSession:session error:nil];
        }
    }];
}

- (void)requestUserSession:(FCTwitterAppSession *)userSession {
    NSAssert(userSession.auth_Token.length, @"deeplink参数缺失");
    NSDictionary *paramters = @{@"oauth_token":userSession.auth_Token};
    self.authSecret = userSession.auth_Secret;
    FCBaseRequest *api = [self baseRequestApi:TwitterSessionVerifyUrl paramters:paramters httpMethod:FCHttpMethodGET];
    [api startRequest:^(NSData *response, NSError *error) {
        NSLog(@"1");
    }];
}

//(lldb) po signatureSecret
//ZvB0idM0dfldEbaFPS90aYB2SpYBHcg85LyHnTtOmdyuCizlfD&GPUoxd53wKlOLSTg85bFzS5XCsdbzbMTrj4cwx0KEM3i0
//
//(lldb) po OAuthParameters
//{
//    "oauth_consumer_key" = HyjS1LXB00MCPibyxWVQ6aryX;
//    "oauth_nonce" = "4C8416C1-0477-4308-A367-92573458E421";
//    "oauth_signature_method" = "HMAC-SHA1";
//    "oauth_timestamp" = 1525662611;
//    "oauth_token" = "971303193052434432-bwMfLP9pQgunP0HdL8rFyssTBZfjc3M";
//    "oauth_version" = "1.0";
//}

#pragma mark private getApi
- (FCBaseRequest *)baseRequestApi: (NSString *)url paramters: (NSDictionary *)customParamters httpMethod: (FCHttpMethod)method {
    FCBaseRequest *api = [FCBaseRequest new];
    api.absoluteUrl = url;
    api.httpMethod = method;
    NSMutableDictionary *paramters = [self getApiBaseParamters];
    [paramters addEntriesFromDictionary:customParamters];
    NSString *signBody = [api.absoluteUrl twitter_signBodyWithParamter:paramters];
    paramters[@"oauth_signature"] = [self.signKey twitter_signStrWithSignBody:signBody];
    NSString *header = [NSString twitter_authEncodeWithParamter:paramters];
    api.httpHeader = @{@"Authorization":header,
                       @"Accept-Encoding":@"gzip"};
    return api;
}

#pragma mark Private httpConfig
- (NSMutableDictionary *)getApiBaseParamters {
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

- (void)loginCompletionCallBackWithSession:(FCTwitterAppSession *)session error:(NSError *)error {
    if (self.LoginCompletion) {
        self.LoginCompletion(session, error);
    }
}

#pragma mark getter
- (NSURL *)twitterOpenUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"twitterauth://authorize?consumer_key=%@&consumer_secret=%@&oauth_callback=twitterkit-%@", self.appConfig.appKey, self.appConfig.appSecret, self.appConfig.redirectUrl]];
}

@end
