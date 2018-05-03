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

@interface FCBaseRequest ()

@property (nonatomic, copy) NSURL *requestURL;

@end

@implementation FCBaseRequest

- (FCCallBack *)startRequest {
    FCCallBack *callBack = [FCCallBack new];
    if (![self isAvailableURL]) {
        FCError *urlError = [FCError errorWithMessage:@"不可用的URL"];
        [callBack delaySendError:urlError];
        return callBack;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestURL];
    request.HTTPMethod = [self httpMethodString];
    [self configRequestHeader:request];
    request.HTTPBody = [self httpParamters];
    
    __weak typeof(self) weakSelf = self;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            [callBack sendError:error];
        } else {
            if (![weakSelf verifyRequestResult:response]) {
                FCError *customError = [FCError errorWithCode:-1 message:@"auth failed"];
                [callBack sendError:customError];
            } else {
                [callBack sendSuccess:[data transformToMap]];
            }
        }
    }] resume];
    return callBack;
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
    NSString *requestParamters = [[self.paramters transformPathFormat] subStringToSecondLast];
    if (!requestParamters.length) {
        return nil;
    }
    return [requestParamters dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)httpMethodString {
    if (self.httpMethod == FCHttpMethodGet) {
        return @"GET";
    } else {
        return @"POST";
    }
}

- (NSURL *)requestURL {
    return [NSURL URLWithString:self.absoluteUrl];
}

- (NSString *)absoluteUrl {
    if (_absoluteUrl.length)
        return _absoluteUrl;
    return [self.baseHost appendAbsolutString:self.path];
}

- (BOOL)verifyRequestResult: (NSURLResponse *)response {
    NSHTTPURLResponse *urlResponse = [self checkReponseClass:response];
    if (!urlResponse) {
        return YES;
    }
    return (urlResponse.statusCode >= 200 || urlResponse.statusCode < 300);
}

- (NSHTTPURLResponse *)checkReponseClass: (NSURLResponse *)reponse {
    if ([reponse isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *httpReponse = (NSHTTPURLResponse *)reponse;
        return httpReponse;
    }
    return nil;
}

@end
