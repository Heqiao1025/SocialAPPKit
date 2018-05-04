//
//  FCTwitterAppKit.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/20.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FCTwitterAppSession.h"
#import "FCError.h"
#import "FCCallBack.h"

#define TwitterInstance [FCTwitterAppKit shareInstance]

@interface FCTwitterAppKit : NSObject

+ (instancetype)shareInstance;

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret redirectUrl: (NSString *)redirectUrl;

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;

// sso level：app auth -> web auth
/**
 OAuth
 返回数据FCTwitterAppSession类包含: username. userID. auth_token. auth_secret.
 */
- (FCCallBack *)logIn;

/**
 OAuth
 快速登录(只在iphone中包含twitterapp有效)
 返回数据FCTwitterAppSession类包含: username. auth_token. auth_secret
 */
- (FCCallBack *)quickLogIn;

@end
