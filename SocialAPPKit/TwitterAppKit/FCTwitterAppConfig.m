//
//  FCTwitterAppConfig.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/26.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCTwitterAppConfig.h"

@interface FCTwitterAppConfig ()

@property (nonatomic, copy, readwrite) NSString *appKey;

@property (nonatomic, copy, readwrite) NSString *appSecret;

@property (nonatomic, copy, readwrite) NSString *redirectUrl;

@end

@implementation FCTwitterAppConfig

- (void)setAppKey: (NSString *)appkey       appSecret: (NSString *)appSecret redirectUrl: (NSString *)redirectUrl {
    self.appKey = appkey;
    self.appSecret = appSecret;
    self.redirectUrl = redirectUrl;
}

@end
