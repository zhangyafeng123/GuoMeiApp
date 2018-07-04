//
//  ZYFGoodDetailViewController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/1.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFGoodDetailViewController.h"
//Controllers
#import "ZYFGoodBaseViewController.h"
#import "ZYFGoodParticularsViewController.h"
#import "ZYFGoodCommentViewController.h"
@interface ZYFGoodDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UIView *bgView;
/** 记录上一次选中的button **/
@property(nonatomic, weak) UIButton *selectBtn;
/** 标题按钮地下的指示器 **/
@property(nonatomic, weak) UIView *indicatorView;
/** 通知 **/
@property(nonatomic, weak) id zyfObserver;
@end

@implementation ZYFGoodDetailViewController
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.bounces = NO;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
        
        
    }
    return _scrollerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildViewControllers];
    
    [self setUpInit];
    
    [self setUpNav];
    
    [self setUpTopButtonView];
    
    [self addChildViewController];
    
    [self setUpBottomButton];

}
- (void)setUpChildViewControllers
{
    WEAKSELF
    ZYFGoodBaseViewController *goodBaseVc = [[ZYFGoodBaseViewController alloc] init];
    goodBaseVc.goodTitle = _goodTitle;
    goodBaseVc.goodPrice = _goodPrice;
    goodBaseVc.goodSubtitle = _goodSubtitle;
    goodBaseVc.shufflingArray = _shufflingArray;
    goodBaseVc.goodImageView = _goodImageView;
    goodBaseVc.changeTitleBlock = ^(BOOL isChange) {
        
    };
    [self addChildViewController:goodBaseVc];
    
    ZYFGoodParticularsViewController *goodParticularVc = [ZYFGoodParticularsViewController new];
    [self addChildViewController:goodParticularVc];
    
    ZYFGoodCommentViewController *goodCommentVc = [ZYFGoodCommentViewController new];
    [self addChildViewController:goodCommentVc];
    
}
#pragma mark ---- init ----
- (void)setUpInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(self.view.dc_width * self.childViewControllers.count, 0);
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)addChildViewController
{
    NSInteger index = _scrollerView.contentOffset.x / _scrollerView.dc_width;
    UIViewController *childVC = self.childViewControllers[index];
    if (childVC.view.superview) return;//判断添加了就不再添加了
    childVC.view.frame = CGRectMake(index *_scrollerView.dc_width, 0, _scrollerView.dc_width, _scrollerView.dc_height);
    [_scrollerView addSubview:childVC.view];
}



#pragma mark - 导航栏设置
- (void)setUpNav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"Details_Btn_More_normal"] WithHighlighted:[UIImage imageNamed:@"Details_Btn_More_normal"] Target:self action:@selector(toolItemClick)];
}
#pragma mark ---- 头部view ----
- (void)setUpTopButtonView
{
    NSArray *titles = @[@"商品",@"详情",@"评价"];
    CGFloat margin = 5;
    _bgView = [UIView new];
    _bgView.dc_centerX = ScreenW * 0.5;
    _bgView.dc_height = 44;
    _bgView.dc_width = (_bgView.dc_height + margin) * titles.count;
    _bgView.dc_y = 0;
    self.navigationItem.titleView = _bgView;
    
    CGFloat buttonW = _bgView.dc_height;
    CGFloat buttonH = _bgView.dc_height;
    CGFloat buttonY = _bgView.dc_y;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:titles[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        button.tag = i;
        button.titleLabel.font = PFR16Font;
        [button addTarget:self action:@selector(topButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        CGFloat buttonX = i * (buttonW + margin);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [_bgView addSubview:button];
    }
    
    UIButton *firstButton = _bgView.subviews[0];
    [self topButtonClick:firstButton];//默认选中第一个
    
    UIView *indicatorView = [[UIView alloc] init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:(UIControlStateSelected)];
    
    indicatorView.dc_height = 2;
    indicatorView.dc_y = _bgView.dc_height - indicatorView.dc_height;
    
    [firstButton.titleLabel sizeToFit];
    indicatorView.dc_width = firstButton.titleLabel.dc_width;
    indicatorView.dc_centerX = firstButton.dc_centerX;
    [_bgView addSubview:indicatorView];
    
}
/** 头部按钮点击事件 **/
- (void)topButtonClick:(UIButton *)sender
{
    sender.selected  = !sender.selected;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    
    _selectBtn = sender;
    
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = sender.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = sender.dc_centerX;
    }];
    CGPoint offset = _scrollerView.contentOffset;
    offset.x = _scrollerView.dc_width * sender.tag;
    [_scrollerView setContentOffset:offset animated:YES];
}
#pragma mark - 底部按钮(收藏 购物车 加入购物车 立即购买)
- (void)setUpBottomButton
{
    [self setUpLeftTwoButton];//收藏 购物车
    
    [self setUpRightTwoButton];//加入购物车 立即购买
}
#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"tabr_07shoucang_up",@"tabr_08gouwuche"];
    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"tabr_08gouwuche"];
    CGFloat buttonW = ScreenW * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = ScreenW * 0.6 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGB(249, 125, 10);
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.4 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}
- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 1){
        NSLog(@"购物车");
//        DCMyTrolleyViewController *shopCarVc = [[DCMyTrolleyViewController alloc] init];
//        shopCarVc.isTabBar = YES;
//        shopCarVc.title = @"购物车";
//        [self.navigationController pushViewController:shopCarVc animated:YES];
    }else  if (button.tag == 2 || button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",button.tag],@"buttonTag", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:SELECTCARTORBUY object:nil userInfo:dict];
        });
    }
}
#pragma mark ---- UIScrollViewDelegate ----

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildViewController];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
    UIButton *button  = _bgView.subviews[index];
    
    [self topButtonClick:button];
    
    [self addChildViewController];
}






























































@end
