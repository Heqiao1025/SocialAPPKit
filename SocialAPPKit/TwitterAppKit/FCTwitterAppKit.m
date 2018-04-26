//
//  FCTwitterAppKit.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/20.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCTwitterAppKit.h"
#import "FCTwitterAppConfig.h"

@interface FCTwitterAppKit ()

@property (nonatomic, strong) FCTwitterAppConfig *appConfigModel;

@end

@implementation FCTwitterAppKit

+ (instancetype)shareInstance {
    static FCTwitterAppKit *twitterKit;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        twitterKit = [self new];
        [twitterKit configModel];
    });
    return twitterKit;
}

- (void)configModel {
    self.appConfigModel = [FCTwitterAppConfig new];
}

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret redirectUrl: (NSString *)redirectUrl {
    [self.appConfigModel setAppKey:appkey appSecret:appSecret redirectUrl:redirectUrl];
}

- (void)registerAppKey: (NSString *)appkey appSecret: (NSString *)appSecret {
    [self registerAppKey:appkey appSecret:appSecret redirectUrl:nil];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    return YES;
}

@end
