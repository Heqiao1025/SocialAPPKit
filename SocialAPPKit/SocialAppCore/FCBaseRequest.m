//
//  FCNetRequest.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCBaseRequest.h"
#import "NSData+FCData.h"
#import "NSString+FCString.h"
#import "NSDictionary+FCDictionary.h"
#import "FCError.h"

@interface FCBaseRequest ()

@property (nonatomic, copy) NSURL *requestURL;

@end

@implementation FCBaseRequest

- (void)startRequest:(RequestCallBack)callBack {
    if (![self isAvailableURL] && callBack) {
        FCError *urlError = [FCError errorWithMessage:@"不可用的URL"];
        callBack(nil, urlError);
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestURL];
    request.HTTPMethod = [self httpMethodString];
    [self configRequestHeader:request];
    request.HTTPBody = [self httpParamters];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        callBack(data, error);
    }] resume];
}

#pragma mark Private Profession
- (BOOL)isAvailableURL {
    return self.requestURL.absoluteString.length ? YES : NO;
}

#pragma mark Private Config
- (void)configRequestHeader: (NSMutableURLRequest *)request {
    for (NSString *key in self.httpHeader) {
        [request setValue:self.httpHeader[key] forHTTPHeaderField:key];
    }
}

- (NSData *)httpParamters {
    NSString *requestParamters = [[self.paramters transformToPathFormat] subStringToSecondLast];
    if (!requestParamters.length) {
        return nil;
    }
    return [requestParamters dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)httpMethodString {
    if (self.httpMethod == FCHttpMethodGET) {
        return @"GET";
    } else {
        return @"POST";
    }
}

- (NSURL *)requestURL {
    return [NSURL URLWithString:self.absoluteUrl];
}

@end
