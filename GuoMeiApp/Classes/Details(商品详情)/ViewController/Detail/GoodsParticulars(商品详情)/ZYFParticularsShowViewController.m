//
//  ZYFParticularsShowViewController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/3.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFParticularsShowViewController.h"
#import <WebKit/WebKit.h>
@interface ZYFParticularsShowViewController ()
@property (strong, nonatomic) WKWebView *webView;
@end

@implementation ZYFParticularsShowViewController
#pragma mark - LazyLoad

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = self.view.bounds;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBase];
    
    [self setUpGoodsParticularsWKWebView];
}

- (void)setUpBase
{
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.backgroundColor = self.view.backgroundColor;
}

- (void)setUpGoodsParticularsWKWebView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_particularUrl]];
    [self.webView loadRequest:request];
}
@end
