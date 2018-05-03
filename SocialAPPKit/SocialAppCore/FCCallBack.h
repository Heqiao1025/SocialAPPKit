//
//  FCCallBack.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCError.h"

@interface FCCallBack : NSObject

- (void)subscriberSuccess :(void (^)(id x))successCallBack;

- (void)subscriberSuccess :(void (^)(id x))successCallBack error :(void (^) (NSError *error))errorCallBlock;

- (void)sendError :(NSError *)error;

- (void)sendSuccess :(id)success;

- (void)delaySendError :(NSError *)error;

- (void)delaySendSuccess :(id)success;

@end
