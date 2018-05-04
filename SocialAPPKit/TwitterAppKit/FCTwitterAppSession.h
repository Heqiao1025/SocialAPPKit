//
//  FCTwitterAppSession.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/26.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCTwitterAppSession : NSObject

@property (nonatomic, copy, readonly) NSString *auth_Token;

@property (nonatomic, copy, readonly) NSString *auth_Secret;

@property (nonatomic, copy, readonly) NSString *auth_UserID;

@property (nonatomic, copy, readonly) NSString *auth_UserName;

+ (instancetype)initWithAuthToken: (NSString *)token secret: (NSString *)secret userName: (NSString *)userName;

+ (instancetype)initWithAuthToken: (NSString *)token secret: (NSString *)secret userID: (NSString *)userID userName: (NSString *)userName;

@end
