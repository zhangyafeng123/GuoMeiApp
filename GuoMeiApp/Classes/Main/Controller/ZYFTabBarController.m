//
//  ZYFTabBarController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFTabBarController.h"

#import "ZYFNavigationController.h"
#import "ZYFLoginViewController.h"
#import "ZYFBeautyMessageViewController.h"

#import "ZYFTabBadgeView.h"
@interface ZYFTabBarController ()<UITabBarControllerDelegate>
//美信
@property(nonatomic, weak) ZYFBeautyMessageViewController *beautyMsgVc;
@property (nonatomic, strong) NSMutableArray *tabBarItems;
//给item加上badge
@property(nonatomic, weak) UITabBarItem *item;
@end

@implementation ZYFTabBarController

- (NSMutableArray *)tabBarItems
{
    if (!_tabBarItems) {
        _tabBarItems = [NSMutableArray new];
    }
    return _tabBarItems;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //添加通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadgeValue) name:DCMESSAGECOUNTCHANGE object:nil];
    //添加badgeView
    [self addBadgeViewOnTabBarButtons];
    
    WEAKSELF
    [[NSNotificationCenter defaultCenter] addObserverForName:LOGINOFFSELECTCENTERINDEX object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        weakSelf.selectedViewController = [weakSelf.viewControllers objectAtIndex:ZYFtabBarControllerHome]; //默认选择商城index为1
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.delegate = self;
    [self addZYFChildViewControllers];
    self.selectedViewController = [self.viewControllers objectAtIndex:ZYFtabBarControllerHome]; //默认选择商城index为1
}
#pragma mark ---- 添加子控制器 ----
- (void)addZYFChildViewControllers
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"ZYFBeautyMessageViewController",
                              MallTitleKey  : @"美信",
                              MallImgKey    : @"tabr_01_up",
                              MallSelImgKey : @"tabr_01_down"},
                            
                            @{MallClassKey  : @"ZYFHandPickViewController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"tabr_02_up",
                              MallSelImgKey : @"tabr_02_down"},
                            
                            @{MallClassKey  : @"ZYFMediaListViewController",
                              MallTitleKey  : @"美媒榜",
                              MallImgKey    : @"tabr_03_up",
                              MallSelImgKey : @"tabr_03_down"},
                            
                            @{MallClassKey  : @"ZYFBeautyShopViewController",
                              MallTitleKey  : @"美店",
                              MallImgKey    : @"tabr_04_up",
                              MallSelImgKey : @"tabr_04_down"},
                            
                            @{MallClassKey  : @"ZYFMyCenterViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tabr_05_up",
                              MallSelImgKey : @"tabr_05_down"},
                            
                            ];
    
    [childArray enumerateObjectsUsingBlock:^(id  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        vc.view.backgroundColor = [UIColor whiteColor];
        ZYFNavigationController *nav = [[ZYFNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);//（当只有图片的时候）需要自动调整
        [self addChildViewController:nav];
        WEAKSELF
        if ([dict[MallTitleKey] isEqualToString:@"美信"]) {
            weakSelf.beautyMsgVc = (ZYFBeautyMessageViewController *)vc;//给美信赋值
        }
        [self.tabBarItems addObject:vc.tabBarItem];
        
    }];
    
}

#pragma mark ---- 跳转控制器拦截 ----
/** 该方法用于控制TabBarItem能不能选中，返回NO，将禁止用户点击某一个TabBarItem被选中。但是程序内部还是可以通过直接setSelectedIndex选中该TabBarItem **/
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (viewController == [tabBarController.viewControllers objectAtIndex:ZYFtabBarControllerPerson]) {
        /** 判断如果没有登录跳转到登录 **/
        if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
            
            ZYFLoginViewController *loginVC = [ZYFLoginViewController new];
            [self presentViewController:loginVC animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}
#pragma mark ---- UITabBarControllerDelegate ----
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(nonnull UIViewController *)viewController
{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    if ([self.childViewControllers.firstObject isEqual:viewController]) {
        //根据tabBar的内存地址找到美信发送jump通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:nil];
    }
}

- (UIControl *)getTabBarButton
{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    return tabBarButton;
}
#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}
#pragma mark - 更新badgeView
- (void)updateBadgeValue
{
    //更新美信的角标
    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
}


#pragma mark - 添加所有badgeView
- (void)addBadgeViewOnTabBarButtons {
    
    // 设置初始的badegValue
    _beautyMsgVc.tabBarItem.badgeValue = [DCObjManager dc_readUserDataForKey:@"isLogin"];
    
    int i = 0;
    for (UITabBarItem *item in self.tabBarItems) {
        
        if (i == 0) {  // 只在美信上添加
            [self addBadgeViewWithBadgeValue:item.badgeValue atIndex:i];
            // 监听item的变化情况
            [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
            _item = item;
        }
        i++;
    }
}

- (void)addBadgeViewWithBadgeValue:(NSString *)badgeValue atIndex:(NSInteger)index {
    
    ZYFTabBadgeView *badgeView = [ZYFTabBadgeView buttonWithType:UIButtonTypeCustom];
    
    CGFloat tabBarButtonWidth = self.tabBar.dc_width / self.tabBarItems.count;
    
    badgeView.dc_centerX = index * tabBarButtonWidth + 40;
    
    badgeView.tag = index + 1;
    
    badgeView.badgeValue = badgeValue;
    
    [self.tabBar addSubview:badgeView];
}

#pragma mark - 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:[ZYFTabBadgeView class]]) {
            if (subView.tag == 1) {
                ZYFTabBadgeView *badgeView = (ZYFTabBadgeView *)subView;
                badgeView.badgeValue = _beautyMsgVc.tabBarItem.badgeValue;
            }
        }
    }
    
}





#pragma mark - 移除通知
- (void)dealloc {
    [_item removeObserver:self forKeyPath:@"badgeValue"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 禁止屏幕旋转
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
//
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
//}

@end
