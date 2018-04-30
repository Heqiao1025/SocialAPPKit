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

- (instancetype)initWithConfigModel: (FCTwitterAppConfig *)appConfig;

- (FCCallBack *)startAuth;

@end
