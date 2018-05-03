//
//  NSString+FCString.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/21.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FCString)

+ (NSString *)safeString: (id)str;

- (NSString *)appendAbsolutString: (NSString *)path;

- (BOOL)isAvailablePath;

- (NSString *)subStringToSecondLast;

- (NSString *)encodedString;

- (BOOL)isURLPathFormat;

- (NSDictionary *)urlPathFormatTransformMap;

@end
