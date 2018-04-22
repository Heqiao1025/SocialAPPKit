//
//  FCCallBack.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCCallBack.h"

@interface FCCallBack ()

@property (nonatomic, copy) void (^successCallBack)(id x);

@property (nonatomic, copy) void (^errorCallBack) (FCError *);

@end

@implementation FCCallBack

- (void)subscriberSuccess :(void (^)(id x))successCallBack {
    [self subscriberSuccess:successCallBack error:nil];
}

- (void)subscriberSuccess :(void (^)(id x))successCallBack error :(void (^) (FCError *error))errorCallBlock {
    self.successCallBack = successCallBack;
    self.errorCallBack = errorCallBlock;
}

- (void)sendError :(FCError *)error {
    if (self.errorCallBack) {
        self.errorCallBack(error);
        self.errorCallBack = nil;
    }
}

- (void)sendSuccess :(id)success {
    if (self.successCallBack) {
        self.successCallBack(success);
        self.successCallBack = nil;
    }
}

- (void)afterSendError :(FCError *)error {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendError:error];
    });
}

- (void)afterSendSuccess :(id)success {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendSuccess:success];
    });
}

@end
