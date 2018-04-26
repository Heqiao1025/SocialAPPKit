//
//  FCTwitterAppConfig.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/26.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCTwitterAppConfig : NSObject

@property (nonatomic, copy, readonly) NSString *appKey;

@property (nonatomic, copy, readonly) NSString *appSecret;

@property (nonatomic, copy, readonly) NSString *redirectUrl;

+ (instancetype)initWithConsumerKey: (NSString *)appkey consumerSecret: (NSString *)appSecret redirectUrl: (NSString *)redirectUrl;

@end
