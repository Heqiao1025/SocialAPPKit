//
//  NSString+FCString.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "NSString+FCString.h"

@implementation NSString (FCString)

#pragma mark public

+ (NSString *)safeString: (id)str {
    if ([str isKindOfClass:[NSNull class]] || str == NULL || str == nil) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",str];
}

- (NSString *)appendAbsolutString: (NSString *)path {
    NSString *absolutStr = [self stringByAppendingFormat:@"%@%@", [path getAppendString], path];
    return [absolutStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (BOOL)isAvailablePath {
    return [self hasPrefix:@"/"];
}

- (NSString *)subStringToSecondLast {
    return self.length ? [self substringToIndex:self.length-1] : nil;
}

- (NSString *)encodedString {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"\n:#/%?@!$&'()*+,;="].invertedSet];
}

- (BOOL)isURLPathFormat {
    return [self containsString:@"="] || [self containsString:@"&"];
}

- (NSDictionary *)urlPathFormatTransformMap {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    NSString *urlPaths = [self componentsSeparatedByString:@"?"].lastObject;
    NSArray *pathArray = [urlPaths componentsSeparatedByString:@"&"];
    for (NSString *pathAbsolute in pathArray) {
        NSArray *path = [pathAbsolute componentsSeparatedByString:@"="];
        if (!path.count) {
            continue;
        }
        resultDic[path.firstObject] = path.lastObject;
    }
    return resultDic;
}

#pragma mark Private
- (NSString *)getAppendString {
    return [self isAvailablePath] ? @"" : @"/";
}

@end
