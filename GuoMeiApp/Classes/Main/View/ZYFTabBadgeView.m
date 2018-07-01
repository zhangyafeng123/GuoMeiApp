//
//  ZYFTabBadgeView.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/1.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFTabBadgeView.h"

@implementation ZYFTabBadgeView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBase];
    }
    return self;
}
- (void)setUpBase
{
    self.userInteractionEnabled = YES;
    self.titleLabel.font = PFR11Font;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.backgroundColor = RGB(226, 70, 157);
    
    WEAKSELF
    [[NSNotificationCenter defaultCenter] addObserverForName:@"jump" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"transform.scale";
        animation.values = @[@1.0,@1.1,@0.9,@1.0];
        animation.duration = 0.3;
        animation.calculationMode = kCAAnimationCubic;
        //添加动画
        [weakSelf.layer addAnimation:animation forKey:nil];
    }];

}
#pragma mark ---- 赋值 ----
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    [self setBadgeViewWithbadgeValue:badgeValue];
}
#pragma mark ---- 设置 ----
- (void)setBadgeViewWithbadgeValue:(NSString *)badgeValue
{
    //设置文字内容
    [self setTitle:badgeValue forState:(UIControlStateNormal)];
    //判断是否有内容，设置隐藏属性
    self.hidden = (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) ? YES : NO;
    NSInteger badgeNumber = [badgeValue integerValue];
    //如果文字尺寸大于控件宽度
    if (badgeNumber > 99) {
        [self setTitle:@"99+" forState:(UIControlStateNormal)];
    }
    
    self.dc_size = CGSizeMake(22, 22);
    
}
























@end
