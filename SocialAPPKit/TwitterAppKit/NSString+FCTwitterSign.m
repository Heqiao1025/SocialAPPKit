//
//  NSString+FCTwitterSign.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/30.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "NSString+FCTwitterSign.h"
#import "NSDictionary+FCDictionary.h"
#import "NSString+FCString.h"
#import "NSData+FCData.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (FCTwitterSign)

- (NSData *)hashStrSign: (NSString *)signBody {
    NSData *hashData = [signBody dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *digest = malloc(CC_SHA1_DIGEST_LENGTH);
    const char *cKey = [self cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    NSData *signData = [NSData dataWithBytes:digest length:20];
    free(digest);
    cKey = nil;
    return signData;
}

- (NSString *)twitter_signStrWithSignBody: (NSString *)signBody {
    NSData *signData = [self hashStrSign:signBody];
    return [signData base64EncodedString];
}

- (NSString *)twitter_signBodyWithParamter: (NSMutableDictionary *)paramters {
    NSArray *sortKeys = [paramters sortKeyArr];
    NSMutableDictionary *encodeParamters = [paramters encodeAllValue];
    NSString *path = [[encodeParamters transformPathFormatWithSortKey:sortKeys] subStringToSecondLast];
    NSString *encodePath = [path encodedString];
    NSString *encodeHost = [self encodedString];
    return [NSString stringWithFormat:@"POST&%@&%@", encodeHost, encodePath];
}

+ (NSString *)twitter_authEncodeWithParamter: (NSMutableDictionary *)paramters {
    NSArray *sortKeys = [paramters sortKeyArr];
    
    NSString *paraString = [[[paramters encodeAllValue] transformEncodeFormatWithSortKey:sortKeys] subStringToSecondLast];
    return [@"OAuth " stringByAppendingString:paraString];
}

@end
