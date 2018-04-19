//
//  WechatSocialKit.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/19.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "WechatSocialKit.h"

@implementation WechatSocialKit

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"wechat");
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        NSLog(@"%@", bundle);
    }
    return self;
}

@end
