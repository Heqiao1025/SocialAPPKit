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

@end
