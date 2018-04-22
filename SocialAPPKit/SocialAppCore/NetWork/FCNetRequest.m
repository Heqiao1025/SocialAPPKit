//
//  FCNetRequest.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCNetRequest.h"
#import "NSData+FCData.h"
#import "NSString+FCString.h"
#import "NSURLResponse+FCNetRequest.h"

@interface FCNetRequest()

@property (nonatomic, copy) NSURL *requestURL;

@end

@implementation FCNetRequest

- (FCCallBack *)startRequest {
    FCCallBack *callBack = [FCCallBack new];
    if ([self isAvailableURL]) {
        FCError *urlError = [FCError errorWithMessage:@"不可用的URL"];
        [callBack afterSendError:urlError];
        return callBack;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestURL];
    request.HTTPMethod = [self HttpMethodString];
    [self configRequestHeader:request];
    request.HTTPBody = [self httpParamters];
    [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error || [response fc_requestSuccess]) {
            FCError *customError = [FCError errorWithCode:0 message:error.userInfo[@"message"]];
            [callBack sendError:customError];
        } else {
            //            NSDictionary *json = [data transformData];
            [callBack sendSuccess:data];
        }
    }];
    return callBack;
}

#pragma mark Private Profession
- (BOOL)isAvailableURL {
    return self.requestURL.absoluteString.length ? YES : NO;
}

#pragma mark Private HttpConfig
- (void)configRequestHeader: (NSMutableURLRequest *)request {
    for (NSString *key in self.httpHeader) {
        [request setValue:self.httpHeader[key] forHTTPHeaderField:key];
    }
}

- (NSData *)httpParamters {
    NSString *requestParamters = [NSString getRequestBodyString:self.paramters];
    if (!requestParamters.length) {
        return nil;
    }
    return [requestParamters dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)HttpMethodString {
    if (self.httpMethod == FCHttpMethodGet) {
        return @"GET";
    } else {
        return @"POST";
    }
}

- (NSURL *)requestURL {
    return [NSURL URLWithString:[self.baseHost appendAbsolutString:self.path]];
}

@end
