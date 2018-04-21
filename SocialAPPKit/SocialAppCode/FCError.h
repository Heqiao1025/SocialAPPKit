//
//  FCError.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCError : NSError

/**
 Error code not identified for use
 */
+ (instancetype)errorWithMessage: (NSString *)message;

/**
 Error code already identification using
 */
+ (instancetype)errorWithCode: (NSInteger)code message: (NSString *)message;

@property (nonatomic, copy, readonly) NSString *message;

@end
