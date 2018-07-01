//
//  AppDelegate.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/27.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYFAppVersionTool.h"
#import "ZYFTabBarController.h"
#import "ZYFFeatureViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - 适配
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self setUpRootVC];//跟控制器判断
    
    [self.window makeKeyAndVisible];
    
    [self setUpFixiOS11];
    
    return YES;
}
#pragma mark ---- 跟控制器判断 ----
- (void)setUpRootVC
{
    NSLog(@"%@",[ZYFAppVersionTool dc_GetLastOneAppVersion]);
    
    if ([BUNDLE_VERSION isEqualToString:[ZYFAppVersionTool dc_GetLastOneAppVersion]]) {
        //判断是否是当前版本号等于上一次存储的版本号
        self.window.rootViewController = [[ZYFTabBarController alloc] init];
    } else {
        //存储当前版本号
        [ZYFAppVersionTool dc_SaveNewAppVersion:BUNDLE_VERSION];
        // 设置窗口的根控制器
        ZYFFeatureViewController *dcFVc = [[ZYFFeatureViewController alloc] init];
        [dcFVc setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
            
            *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
            *showPageCount = YES;
            *showSkip = YES;
        }];
        self.window.rootViewController = dcFVc;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
