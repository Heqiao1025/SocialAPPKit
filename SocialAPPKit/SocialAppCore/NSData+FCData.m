//
//  NSData+FCData.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "NSData+FCData.h"
#import "NSString+FCString.h"

@implementation NSData (FCData)

- (NSString *)transformToString {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)transformToMap {
    NSDictionary *verifyMap = [NSJSONSerialization JSONObjectWithData:self options:0 error:nil];
    return verifyMap;
}

- (NSString *)base64EncodedString {
    if (![self length]) return nil;
    return [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
}

@end
