//
//  FCTwitterAppSession.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/26.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCTwitterAppSession.h"

@interface FCTwitterAppSession ()

@property (nonatomic, copy, readwrite) NSString *auth_Token;

@property (nonatomic, copy, readwrite) NSString *auth_Secret;

@property (nonatomic, copy, readwrite) NSString *auth_UserID;

@property (nonatomic, copy, readwrite) NSString *auth_UserName;

@end

@implementation FCTwitterAppSession

+ (instancetype)initWithAuthToken: (NSString *)token secret: (NSString *)secret userName: (NSString *)userName {
    return [self initWithAuthToken:token secret:secret userID:nil userName:userName];
}

+ (instancetype)initWithAuthToken: (NSString *)token secret: (NSString *)secret userID: (NSString *)userID userName: (NSString *)userName {
    FCTwitterAppSession *session = [self new];
    session.auth_UserID = userID;
    session.auth_UserName = userName;
    session.auth_Secret = secret;
    session.auth_Token = token;
    return session;
}

@end
