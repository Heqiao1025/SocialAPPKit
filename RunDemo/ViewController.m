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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self testTitterAuth];
}

- (void)testTitterAuth {
    [[TwitterInstance logIn] subscriberSuccess:^(id x) {
        
    } error:^(NSError *error) {
        
    }];
}

- (void)testWebView {
    FCWebViewController *vc = [FCWebViewController new];
    vc.webURLString = @"http://www.baidu.com";
    [vc showWebController];
}

- (void)testNetWork {
    FCBaseRequest *api = [FCBaseRequest new];
    api.baseHost = @"http://www.kuaidi100.com";
    api.path = @"/query";
    api.paramters = @{@"type":@"yuantong",
                      @"postid":@"11111111111"};
    [[api startRequest] subscriberSuccess:^(id x) {
        NSLog(@"1");
    } error:^(NSError *error) {
        NSLog(@"2");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
