//
//  FCNetRequest.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCNetRequest.h"
#import "NSData+FCData.h"
#import "NSURLResponse+FCNetRequest.h"

@interface FCNetRequest()

@property (nonatomic, copy) NSURL *requestURL;

@end

@implementation FCNetRequest

- (FCCallBack *)startRequest {
    FCCallBack *callBack = [FCCallBack new];
    if ([self isAvailableURL]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FCError *urlError = [FCError errorWithMessage:@"不可用的URL"];
            [callBack sendError:urlError];
        });
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

#pragma mark Profession
- (BOOL)isAvailableURL {
    BOOL isAvailable = self.requestURL.absoluteString.length ? YES : NO;
    return isAvailable;
}

#pragma mark Private HttpConfig
- (void)configRequestHeader: (NSMutableURLRequest *)request {
    for (NSString *key in self.httpHeader) {
        [request setValue:self.httpHeader[key] forHTTPHeaderField:key];
    }
}

- (NSData *)httpParamters {
    NSString *requestParamters = [NSString string];
    for (NSString *paramter in self.paramters) {
        [requestParamters stringByAppendingFormat:@"%@=%@&", paramter, self.paramters[paramter]];
    }
    return requestParamters.length ?[[requestParamters substringToIndex:requestParamters.length-1] dataUsingEncoding:NSUTF8StringEncoding]: nil;
}

- (NSString *)HttpMethodString {
    if (self.httpMethod == FCHttpMethodGet) {
        return @"GET";
    } else {
        return @"POST";
    }
}

- (NSURL *)requestURL {
    NSString *urlBase = [self.path hasPrefix:@"/"] ? [self.baseHost stringByAppendingString:self.path] : [self.baseHost stringByAppendingFormat:@"/%@", self.path];
    NSString *urlEncode = [urlBase stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:urlEncode];
}

@end
