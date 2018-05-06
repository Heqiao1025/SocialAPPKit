//
//  FCTwitterAppCore.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/26.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FCCallBack;
@class FCTwitterAppConfig;

@interface FCTwitterAppCore : NSObject

@property (nonatomic) BOOL isNeedUserID;

@property (nonatomic, strong) NSURL *twitterOpenUrl;

@property (nonatomic, strong) FCCallBack *authCallBack;

- (instancetype)initWithConfigModel: (FCTwitterAppConfig *)appConfig;

- (void)authWithWeb;

- (void)authWithDeepLink;

- (void)deeplinkURLDataMap: (NSURL *)deeplinkURL;

@end
