//
//  ZYFGoodParticularsViewController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/3.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFGoodParticularsViewController.h"
#import "ZYFParticularsShowViewController.h"
@interface ZYFGoodParticularsViewController ()

@end

@implementation ZYFGoodParticularsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildViewController];
    [self setUpDisplayStyle:^(UIColor *__autoreleasing *titleScrollViewBgColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIColor *__autoreleasing *proColor, UIFont *__autoreleasing *titleFont, CGFloat *titleButtonWidth, BOOL *isShowPregressView, BOOL *isOpenStretch, BOOL *isOpenShade) {
        
        *titleFont = PFR16Font;      //字体尺寸 (默认fontSize为15)
        *norColor = [UIColor darkGrayColor];
        
        /*
         以下BOOL值默认都为NO
         */
        *isShowPregressView = YES;                      //是否开启标题下部Pregress指示器
        *isOpenStretch = YES;                           //是否开启指示器拉伸效果
        *isOpenShade = YES;                             //是否开启字体渐变
    }];

}

#pragma mark - 添加所有子控制器
- (void)setUpAllChildViewController
{
    ZYFParticularsShowViewController *vc01 = [ZYFParticularsShowViewController new];
    vc01.title = @"商品介绍";
    vc01.particularUrl = CDDJianShu01;
    [self addChildViewController:vc01];
    
    ZYFParticularsShowViewController *vc02 = [ZYFParticularsShowViewController new];
    vc02.title = @"规格参数";
    vc02.particularUrl = CDDJianShu02;
    [self addChildViewController:vc02];
    
    ZYFParticularsShowViewController *vc03 = [ZYFParticularsShowViewController new];
    vc03.title = @"包装清单";
    vc03.particularUrl = CDDJianShu03;
    [self addChildViewController:vc03];
    
    ZYFParticularsShowViewController *vc04 = [ZYFParticularsShowViewController new];
    vc04.title = @"售后服务";
    vc04.particularUrl = CDDJianShu04;
    [self addChildViewController:vc04];
    
}

@end
