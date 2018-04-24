//
//  FCWebViewController.m
//  SocialAPPKit
//
//  Created by ForC on 2018/4/20.
//  Copyright © 2018年 ForC. All rights reserved.
//

#import "FCWebViewController.h"
#import <WebKit/WebKit.h>

@interface FCWebViewController ()<WKNavigationDelegate>

@property (nonatomic, copy) NSURL *webUrl;

@property (strong, nonatomic) WKWebView *webView;

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation FCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configBar];
    
    [self configWebView];
    
    [self configProgress];
}

- (void)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSURL *)webUrl {
    return [NSURL URLWithString:self.webURLString];
}

- (NSString *)getTitle {
    if (_socialType == FCSocialWebTypeWechat)
        return @"Wechat";
    if (_socialType == FCSocialWebTypeTencentQQ)
        return @"QQ";
    if (_socialType == FCSocialWebTypeTwitter)
        return @"Twitter";
    if (_socialType == FCSocialWebTypeFaceBook)
        return @"FaceBook";
    if (_socialType == FCSocialWebTypeSinaWeibo)
        return @"WeiBo";
    return @"AliPay";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

#pragma mark Delegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView: (WKWebView *)webView didStartProvisionalNavigation: (null_unspecified WKNavigation *)navigation {
    
}

#pragma mark UI

- (void)configProgress {
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    self.progressView.backgroundColor = self.navigationController.navigationBar.tintColor;
    [self.view addSubview:self.progressView];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)configBar {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    self.title = [self getTitle];
}

- (void)configWebView {
    WKPreferences *prefer = [WKPreferences new];
    prefer.javaScriptCanOpenWindowsAutomatically = YES;
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
    configuration.preferences = prefer;
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.webUrl];
    [self configHeader:request];
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
}

- (void)configHeader: (NSMutableURLRequest *)request {
    for (NSString *key in self.webHeader) {
        [request setValue:self.webHeader[key] forHTTPHeaderField:key];
    }
}

- (void)showWebController {
    UINavigationController *naviagtion = [[UINavigationController alloc] initWithRootViewController:self];
    naviagtion.navigationBar.translucent = NO;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:naviagtion animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
