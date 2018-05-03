//
//  NSString+FCTwitterSign.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/30.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FCTwitterSign)

- (NSString *)twitter_signStrWithSignBody: (NSString *)signBody;

- (NSString *)twitter_signBodyWithParamter: (NSMutableDictionary *)paramters;

+ (NSString *)twitter_authEncodeWithParamter: (NSMutableDictionary *)paramters;

@end
