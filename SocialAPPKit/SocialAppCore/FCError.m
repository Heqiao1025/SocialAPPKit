//
//  FCError.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCError.h"

@implementation FCError

+ (instancetype)errorWithMessage: (NSString *)message {
    return [self errorWithCode:-1 message:message];
}

+ (instancetype)errorWithCode: (NSInteger)code message: (NSString *)message {
    return [[self class] errorWithDomain:@"FCERROR" code:code userInfo:@{@"message":message}];
}

- (NSString *)message {
    return self.userInfo[@"message"];
}

@end
