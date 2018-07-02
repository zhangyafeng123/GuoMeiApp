//
//  ZYFTopLineFootView.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/2.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFTopLineFootView.h"
#import "DCTitleRolling.h"
#import <UIImageView+WebCache.h>

@interface ZYFTopLineFootView ()<UIScrollViewDelegate,CDDRollingDelegate>

/** 滚动 **/
@property (nonatomic, strong) DCTitleRolling *numericalScrollView;
/** 底部 **/
@property (nonatomic, strong) UIView *bottomLineView;
/** 顶部广告宣传图片 **/
@property (nonatomic, strong) UIImageView *topImageView;

@end



@implementation ZYFTopLineFootView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        [self setUpBase];
    }
    return self;
}
- (void)setUpUI
{
    _topImageView = [[UIImageView alloc] init];
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:HomeBottomViewGIFImage]];
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_topImageView];
    
    //初始化
    _numericalScrollView = [[DCTitleRolling alloc] initWithFrame:CGRectMake(0, self.dc_height - 50, self.dc_width, 50) WithTitleData:^(CDDRollingGroupStyle *rollingGroupStyle, NSString *__autoreleasing *leftImage, NSArray *__autoreleasing *rolTitles, NSArray *__autoreleasing *rolTags, NSArray *__autoreleasing *rightImages, NSString *__autoreleasing *rightbuttonTitle, NSInteger *interval, float *rollingTime, NSInteger *titleFont, UIColor *__autoreleasing *titleColor, BOOL *isShowTagBorder) {
        *rollingTime = 0.25;
        *rolTags = @[@"first",@"second",@"three",@"four"];
        *rolTitles = @[@"梅西C罗后悔没早看到",@"世界杯舞台上一共出现了26次点球大战",@"这种方式的成功率只有58%",@"意大利的格罗索就选择打球门的右上角"];
        *rightbuttonTitle = @"查看更多";
        *leftImage = @"shouye_img_toutiao";
        *interval = 1.0;
        *titleFont = 14;
        *isShowTagBorder = YES;
        *titleColor = [UIColor darkGrayColor];
    }];
//    _numericalScrollView.rightButton.backgroundColor = [UIColor redColor];
    _numericalScrollView.moreClickBlock = ^{
        NSLog(@"mall----more");
    };
    
    [_numericalScrollView dc_beginRolling];
    _numericalScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_numericalScrollView];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = DCBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.dc_height - 8, ScreenW, 8);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-50);
    }];
}
- (void)setUpBase
{
    self.backgroundColor = [UIColor whiteColor];
}

- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%zd头条滚动条",index);
}

@end
