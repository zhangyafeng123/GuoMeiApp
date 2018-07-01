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
    
    [self setUpFixiOS11];
    return YES;
}
#pragma mark ---- 跟控制器判断 ----
- (void)setUpRootVC
{
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
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
