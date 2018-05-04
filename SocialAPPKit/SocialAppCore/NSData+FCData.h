//
//  NSData+FCData.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FCData)

- (NSString *)transformToString;

- (NSDictionary *)transformToMap;

- (NSString *)base64EncodedString;

@end
