//
//  FCCategory.m
//  SocialAPPKit
//
//  Created by ForC on 2018/5/4.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCCategory.h"
#import "NSDictionary+FCDictionary.h"
#import "NSString+FCString.h"
#import "NSData+FCData.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (TiwtterString)

+ (NSData *)hashStrSign: (NSString *)signBody signKey: (NSString *)signKey {
    NSData *hashData = [signBody dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *digest = malloc(CC_SHA1_DIGEST_LENGTH);
    const char *cKey = [signKey cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    NSData *signData = [NSData dataWithBytes:digest length:20];
    free(digest);
    cKey = nil;
    return signData;
}

- (NSString *)twitter_signStrWithSignBody: (NSString *)signBody {
    NSData *signData = [NSString hashStrSign:signBody signKey:self];
    return [signData base64EncodedString];
}

- (NSString *)twitter_signBodyWithParamter: (NSMutableDictionary *)paramters {
    NSArray *sortKeys = [paramters sortKeyArr];
    NSMutableDictionary *encodeParamters = [paramters encodeAllValue];
    NSString *path = [[encodeParamters transformToPathFormatWithSortKey:sortKeys] subStringToSecondLast];
    NSString *encodePath = [path encodedString];
    NSString *encodeHost = [self encodedString];
    return [NSString stringWithFormat:@"POST&%@&%@", encodeHost, encodePath];
}

+ (NSString *)twitter_authEncodeWithParamter: (NSMutableDictionary *)paramters {
    NSArray *sortKeys = [paramters sortKeyArr];
    NSString *paraString = [[[paramters encodeAllValue] transformToEncodeFormatWithSortKey:sortKeys] subStringToSecondLast];
    return [@"OAuth " stringByAppendingString:paraString];
}

- (BOOL)twitter_verifyURLSechme: (NSString *)configSechme {
    return [self caseInsensitiveCompare:configSechme] == NSOrderedSame;
}

- (BOOL)twitter_verifySourceApplication {
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];
    return [self hasPrefix:@"com.atebits"] || [self hasPrefix:@"com.twitter"] || [self hasPrefix:@"com.apple"] || [self isEqualToString:bundleID];
}

@end

@implementation NSData (TwitterData)

- (NSDictionary *)twitter_responseDataMap {
    NSString *verifyString = [self transformToString];
    if (verifyString.length) {
        if ([verifyString isURLPathFormat]) {
            return [verifyString urlPathFormatTransformMap];
        } else {
            NSString *message = verifyString.length?verifyString:@"授权失败";
            return @{@"error":@{@"message":message},@"messgae":message};
        }
    }
    NSMutableDictionary *verifyDic = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
    if ([verifyDic.allKeys containsObject:@"error"]) {
        verifyDic[@"message"] = verifyDic[@"error"][@"message"];
    }
    return verifyDic;
}

@end
