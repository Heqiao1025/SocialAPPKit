//
//  NSDictionary+FCDictionary.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/30.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "NSDictionary+FCDictionary.h"
#import "NSString+FCString.h"

@implementation NSDictionary (FCDictionary)

- (NSArray *)sortKeyArr {
    NSArray *sortArr = self.allKeys.mutableCopy;
    return [sortArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
}

- (NSString *)transformToPathFormat {
    return [self transformPathFormatWithSortKey:self.allKeys];
}

- (NSMutableDictionary *)encodeAllValue {
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithCapacity:self.allKeys.count];
    for (NSString *key in self.allKeys) {
        NSString *value = [NSString safeString:self[key]];
        resultDic[key] = [value encodedString];
    }
    return resultDic;
}

- (NSString *)transformToPathFormatWithSortKey: (NSArray *)sortKey {
    NSString *resultStr = [NSString string];
    for (NSString *key in sortKey) {
        NSString *value = self[key];
        resultStr = [resultStr stringByAppendingFormat:@"%@=%@&", key, value];
    }
    return resultStr;
}

- (NSString *)transformToEncodeFormatWithSortKey: (NSArray *)sortKey {
    NSString *resultStr = [NSString string];
    for (NSString *key in sortKey) {
        NSString *value = self[key];
        resultStr = [resultStr stringByAppendingFormat:@"%@=\"%@\", ", key, value];
    }
    return resultStr;
}

@end
