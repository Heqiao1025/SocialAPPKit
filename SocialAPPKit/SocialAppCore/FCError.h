//
//  FCError.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCError : NSError

+ (instancetype)errorWithMessage: (NSString *)message;

+ (instancetype)errorWithCode: (NSInteger)code message: (NSString *)message;

+ (instancetype)errorWithCode: (NSInteger)code userInfo: (NSDictionary *)userInfo;

@property (nonatomic, copy, readonly) NSString *message;

@end

