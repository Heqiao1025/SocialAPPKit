//
//  FCWebViewController.h
//  SocialAPPKit
//
//  Created by ForC on 2018/4/20.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebCallBack)(id response, NSError *error);
typedef enum : NSUInteger {
    FCSocialWebTypeWechat,
    FCSocialWebTypeTencentQQ,
    FCSocialWebTypeSinaWeibo,
    FCSocialWebTypeAlipay,
    FCSocialWebTypeFaceBook,
    FCSocialWebTypeTwitter
} FCSocialWebType;

@interface FCWebViewController : UIViewController

@property (nonatomic, copy) NSString *webURLString;

@property (nonatomic, copy) NSDictionary *webHeader;

@property (nonatomic, assign) FCSocialWebType socialType;

@property (nonatomic, copy) WebCallBack callBack;

@property (nonatomic, strong) NSString *callBackKey;

- (void)showWebController;

@end
