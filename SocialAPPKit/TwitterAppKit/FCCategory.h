//
//  FCCategory.h
//  SocialAPPKit
//
//  Created by ForC on 2018/5/4.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 twitter特有category
 */

@interface NSString (TiwtterString)

- (NSString *)twitter_signStrWithSignBody: (NSString *)signBody;

- (NSString *)twitter_signBodyWithParamter: (NSMutableDictionary *)paramters;

+ (NSString *)twitter_authEncodeWithParamter: (NSMutableDictionary *)paramters;

- (BOOL)twitter_verifySourceApplication;

- (BOOL)twitter_verifyURLSechme: (NSString *)configSechme;

@end

@interface NSData (TwitterData)

- (NSDictionary *)twitter_responseDataMap;

@end
