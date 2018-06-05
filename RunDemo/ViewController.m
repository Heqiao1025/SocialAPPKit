//
//  ViewController.m
//  RunDemo
//
//  Created by ForC on 2018/4/19.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "ViewController.h"
#import "FCBaseRequest.h"
#import "FCWebViewController.h"
#import "FCTwitterAppKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)displayAlert: (NSString *)message {
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"display" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
    [vc addAction:action];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = @[@"FCTiwtterLogin", @"FCTitterOpenUrl", @"FCTestWebView", @"FCTestNetWork"];
    NSArray *selArr = @[@"testTwitterAuth", @"testTwitterOpenUrl", @"testWebView", @"testNetWork"];
    for (int i = 0; i<selArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 60*(i+1), [UIScreen mainScreen].bounds.size.width, 40);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:NSSelectorFromString(selArr[i]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [button sizeToFit];
    }
}

- (void)testTwitterOpenUrl {
    NSURL *url = [NSURL URLWithString:@"twitterkit-HyjS1LXB00MCPibyxWVQ6aryX://secret=GPUoxd53wKlOLSTg85bFzS5XCsdbzbMTrj4cwx0KEM3i0&token=971303193052434432-bwMfLP9pQgunP0HdL8rFyssTBZfjc3M&username=ForCChina"];
    NSDictionary *dic = @{@"UIApplicationOpenURLOptionsOpenInPlaceKey":@"0", @"UIApplicationOpenURLOptionsSourceApplicationKey":@"com.atebits.Tweetie2"};
    [TwitterInstance application:[UIApplication sharedApplication] openURL:url options:dic];
}

- (void)testTwitterAuth {
    __weak typeof(self) weakSelf = self;
    [TwitterInstance logInWithCompletion:^(FCTwitterAppSession *session, NSError *loginError) {
        if (loginError) {
            [weakSelf displayAlert:loginError.userInfo[@"message"]];
        } else {
            [weakSelf displayAlert:[NSString stringWithFormat:@"token:%@\nsecret:%@\nusername:%@\nuserid:%@", session.auth_Token, session.auth_Secret, session.auth_UserName, session.auth_UserID]];
        }
    }];
}

- (void)testWebView {
    FCWebViewController *vc = [FCWebViewController new];
    vc.webURLString = @"http://www.baidu.com";
    [vc showWebController];
}

- (void)testNetWork {
    FCBaseRequest *api = [FCBaseRequest new];
    //    api.baseHost = @"http://www.kuaidi100.com/query?type=yuantong&postid=11111111111";
    api.paramters = @{@"type":@"yuantong",
                      @"postid":@"11111111111"};
    [api startRequest:^(NSData *response, NSError *error) {
        NSLog(@"1");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

