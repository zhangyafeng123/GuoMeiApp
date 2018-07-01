//
//  ZYFNavigationController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFNavigationController.h"
#import <GQGesVCTransition.h>
@interface ZYFNavigationController ()

@end

@implementation ZYFNavigationController
/**
 load初始化一次
 */
+ (void)load
{
    [self setUpBase];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //手势返回
    [GQGesVCTransition validateGesBackWithType:(GQGesVCTransitionTypePanWithPercentRight) withRequestFailToLoopScrollView:YES];
}
#pragma mark - 初始化
+ (void)setUpBase
{
    UINavigationBar *bar  = [UINavigationBar appearance];
    bar.barTintColor = DCBGColor;
    [bar setTintColor:[UIColor darkGrayColor]];
    /**
     是否具有透明属性
     */
    bar.translucent = YES;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
    NSMutableDictionary *attributes  = [NSMutableDictionary dictionary];
    //设置导航栏字体颜色
    UIColor *naiColor = [UIColor blackColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = PFR8Font;
    bar.titleTextAttributes = attributes;
    

}













@end
