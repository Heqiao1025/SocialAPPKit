//
//  ViewController.m
//  RunDemo
//
//  Created by ForC on 2018/4/19.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "ViewController.h"
#import "FCNetRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"1");
    [self testNetWork];
}

- (void)testNetWork {
    FCNetRequest *api = [FCNetRequest new];
    api.baseHost = @"http://www.kuaidi100.com";
    api.path = @"/query";
    api.paramters = @{@"type":@"yuantong",
                      @"postid":@"11111111111"};
    [[api startRequest] subscriberSuccess:^(id x) {
        NSLog(@"1");
    } error:^(FCError *error) {
        NSLog(@"2");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
