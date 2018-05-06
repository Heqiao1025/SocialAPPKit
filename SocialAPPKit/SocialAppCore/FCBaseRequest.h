//
//  FCBaseRequest.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/23.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCallBack.h"

typedef enum : NSUInteger {
    FCHttpMethodGET,
    FCHttpMethodPOST,
} FCHttpMethod;

@interface FCBaseRequest : NSObject

@property (nonatomic) FCHttpMethod httpMethod;

@property (nonatomic, copy) NSString *absoluteUrl;

@property (nonatomic, copy) NSDictionary *httpHeader;

@property (nonatomic, copy) NSDictionary *paramters;

- (FCCallBack *)startRequest;

@end
