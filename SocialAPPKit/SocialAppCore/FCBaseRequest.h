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
    FCHttpMethodGet,
    FCHttpMethodPOST,
} FCHttpMethod;

@interface FCBaseRequest : NSObject

@property (nonatomic) FCHttpMethod httpMethod;

/**
 ip/scheme
 */
@property (nonatomic, copy) NSString *baseHost;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSDictionary  *httpHeader;

@property (nonatomic, copy) NSDictionary  *paramters;

- (FCCallBack *)startRequest;

@end
