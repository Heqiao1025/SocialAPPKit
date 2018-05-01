//
//  NSDictionary+FCDictionary.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/30.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FCDictionary)

- (NSArray *)sortKeyArr;

- (NSString *)transformPathFormat;

- (NSString *)transformPathFormatWithSortKey: (NSArray *)sortKey;

- (NSString *)transformEncodeFormatWithSortKey: (NSArray *)sortKey;

@end
