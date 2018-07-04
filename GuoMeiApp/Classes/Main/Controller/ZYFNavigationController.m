//
//  ZYFNavigationController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFNavigationController.h"
#import <GQGesVCTransition.h>
#import "UIBarButtonItem+DCBarButtonItem.h"
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


#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count >= 1) {
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
}











@end
