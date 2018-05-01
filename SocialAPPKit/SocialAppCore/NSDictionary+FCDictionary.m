//
//  NSDictionary+FCDictionary.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/30.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "NSDictionary+FCDictionary.h"

@implementation NSDictionary (FCDictionary)

- (NSArray *)sortKeyArr {
    NSArray *sortArr = self.allKeys.mutableCopy;
    return [sortArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
}

- (NSString *)transformPathFormat {
    return [self transformPathFormatWithSortKey:self.allKeys];
}

- (NSString *)transformPathFormatWithSortKey: (NSArray *)sortKey {
    NSString *resultStr = [NSString string];
    for (NSString *key in sortKey) {
        NSString *value = self[key];
        resultStr = [resultStr stringByAppendingFormat:@"%@=%@&", key, value];
    }
    return resultStr;
}

- (NSString *)transformEncodeFormatWithSortKey: (NSArray *)sortKey {
    NSString *resultStr = [NSString string];
    for (NSString *key in sortKey) {
        NSString *value = self[key];
        resultStr = [resultStr stringByAppendingFormat:@"%@=\"%@\", ", key, value];
    }
    return resultStr;
}

@end
