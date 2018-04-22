//
//  FCNetRequest.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCCallBack.h"

typedef enum : NSUInteger {
    FCHttpMethodGet,
    FCHttpMethodPOST,
} FCHttpMethod;

@interface FCNetRequest : NSObject

@property (nonatomic) FCHttpMethod httpMethod;

/**
 ip/scheme
 */
@property (nonatomic, copy) NSString *baseHost;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, copy) NSMutableDictionary <NSString *, NSString *> *httpHeader;

/**
 httpBody
 */
@property (nonatomic, copy) NSMutableDictionary <NSString *, NSString *> *paramters;

- (FCCallBack *)startRequest;

@end
