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

+ (instancetype)initWithConsumerKey: (NSString *)appkey consumerSecret: (NSString *)appSecret redirectUrl: (NSString *)redirectUrl {
    FCTwitterAppConfig *configModel = [self new];
    configModel.appKey = appkey;
    configModel.appSecret = appSecret;
    configModel.redirectUrl = redirectUrl;
    return configModel;
}

@end
