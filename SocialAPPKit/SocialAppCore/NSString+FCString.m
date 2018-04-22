//
//  NSString+FCString.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "NSString+FCString.h"

@implementation NSString (FCString)

#pragma mark netRequest
- (NSString *)appendAbsolutString: (NSString *)path {
    NSString *absolutStr = [self stringByAppendingFormat:@"%@%@", [path getAppendString], path];
    return [absolutStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)getAppendString {
    return [self isAvailablePath] ? @"" : @"/";
}

- (BOOL)isAvailablePath {
    return [self hasPrefix:@"/"];
}

+ (NSString *)getRequestBodyString: (NSDictionary *)paramters {
    NSString *bodyString = [NSString string];
    for (NSString *key in paramters.allKeys) {
        [bodyString stringByAppendingFormat:@"%@=%@&", key, paramters[key]];
    }
    return [bodyString subStringToSecondLast];
}

- (NSString *)subStringToSecondLast {
    return self.length ? [self substringToIndex:self.length-1] : nil;
}

@end
