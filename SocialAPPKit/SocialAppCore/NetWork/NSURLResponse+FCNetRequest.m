//
//  NSURLResponse+FCNetRequest.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/22.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "NSURLResponse+FCNetRequest.h"

@implementation NSURLResponse (FCNetRequest)

- (BOOL)fc_requestSuccess {
    if (![self isKindOfClass:[NSHTTPURLResponse class]]) {
        return YES;
    }
    NSHTTPURLResponse *httpReponse = (NSHTTPURLResponse *)self;
    return (httpReponse.statusCode >= 200 || httpReponse.statusCode < 300);
}


@end
