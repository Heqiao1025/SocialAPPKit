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

- (NSData *)hashStrSign: (NSString *)hmacKey {
    NSData *hashData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char *digest = malloc(CC_SHA1_DIGEST_LENGTH);
    const char *cKey = [hmacKey cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), [hashData bytes], [hashData length], digest);
    NSData *signData = [NSData dataWithBytes:digest length:20];
    free(digest);
    cKey = nil;
    return signData;
}

- (NSString *)twitter_signStrWithParamters: (NSMutableDictionary *)paramters signKey: (NSString *)signKey {
    NSString *signBody = [self signBodyWithParamter:paramters];
    NSData *signData = [signKey hashStrSign:signBody];
    return [signData base64EncodedString];
}

- (NSString *)signBodyWithParamter: (NSMutableDictionary *)paramters {
    NSArray *sortKeys = [paramters sortKeyArr];
    NSString *path = [[paramters transformPathFormatWithSortKey:sortKeys] subStringToSecondLast];
    NSString *encodePath = [path encodedString];
    NSString *encodeHost = [self encodedString];
    return [NSString stringWithFormat:@"POST&%@&%@", encodeHost, encodePath];
}

@end
