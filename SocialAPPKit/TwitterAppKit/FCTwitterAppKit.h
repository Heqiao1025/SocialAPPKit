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

@interface FCTwitterAppKit : NSObject

+ (instancetype)shareInstance;

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret redirectUrl: (NSString *)redirectUrl;

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret;

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;


/**
 login
 Consumer can get more information
 format: username. userID. auth_token. auth_secret.
 */
- (FCCallBack *)logIn;

/**
 login
 Consumer can get information
 format: username. auth_token. auth_secret
 */
- (FCCallBack *)quickLogIn;

@end
