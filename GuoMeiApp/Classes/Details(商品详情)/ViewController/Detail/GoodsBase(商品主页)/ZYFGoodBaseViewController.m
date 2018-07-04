//
//  ZYFGoodBaseViewController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/3.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFGoodBaseViewController.h"
#import <WebKit/WebKit.h>
#import "DCDetailGoodReferralCell.h"
#import "DCDetailShufflingHeadView.h"
#import "ZYFShowTypeFourCell.h"
#import "ZYFShowTypeOneCell.h"
#import "ZYFShowTypeTwoCell.h"
#import "ZYFShowTypeThreeCell.h"
#import "ZYFDetailServicetCell.h"
#import "DCUserInfo.h"
#import "ZYFFeatureSelectionViewController.h"

// Categories
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

@interface ZYFGoodBaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WKWebView *webView;

/** 通知 **/
@property(nonatomic, weak) id zyfObj;
@end
/** cell **/
static NSString * const DCDetailGoodReferralCellID = @"DCDetailGoodReferralCell";
static NSString * const ZYFShowTypeFourCellID = @"ZYFShowTypeFourCell";
static NSString * const  ZYFShowTypeOneCellID = @"ZYFShowTypeOneCell";
static NSString * const ZYFShowTypeTwoCellID = @"ZYFShowTypeTwoCell";
static NSString * const ZYFShowTypeThreeCellID = @"ZYFShowTypeThreeCell";
static NSString * const ZYFDetailServicetCellID = @"ZYFDetailServicetCell";

/** header **/
static NSString * const DCDetailShufflingHeadViewID = @"DCDetailShufflingHeadView";

static NSString *lastNum_;
static NSArray *lastSeleArray_;

@implementation ZYFGoodBaseViewController
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.contentSize  = CGSizeMake(ScreenW, (ScreenH - 50) * 2);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = NO;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;//Y
        layout.minimumInteritemSpacing = 0;//X
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, DCTopNavH, ScreenW, ScreenH - DCTopNavH - 50);
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_collectionView];
        
        /** cell **/
        [_collectionView registerClass:[DCDetailGoodReferralCell class] forCellWithReuseIdentifier:DCDetailGoodReferralCellID];
        [_collectionView registerClass:[ZYFShowTypeFourCell class] forCellWithReuseIdentifier:ZYFShowTypeFourCellID];
        [_collectionView registerClass:[ZYFShowTypeOneCell class] forCellWithReuseIdentifier:ZYFShowTypeOneCellID];
        [_collectionView registerClass:[ZYFShowTypeTwoCell class] forCellWithReuseIdentifier:ZYFShowTypeTwoCellID];
        [_collectionView registerClass:[ZYFShowTypeThreeCell class] forCellWithReuseIdentifier:ZYFShowTypeThreeCellID];
        [_collectionView registerClass:[ZYFDetailServicetCell class] forCellWithReuseIdentifier:ZYFDetailServicetCellID];
        
        /** header **/
        [_collectionView registerClass:[DCDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID];
        /** footer **/
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //间隔
    }
    return _collectionView;
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH - 50);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(DCTopNavH, 0, 0, 0);
        _webView.backgroundColor = [UIColor redColor];
        [self.scrollerView addSubview:_webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self acceptanceNote];
}
#pragma mark ---- init ----
- (void)setUpInit
{
    self.view.backgroundColor = DCBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    //初始化
    lastSeleArray_ = [NSArray array];
    lastNum_ = 0;
}
#pragma mark ---- 接收通知 ----
- (void)acceptanceNote
{
    WEAKSELF
    /** 父类加入购物车，立即购买通知 **/
    _zyfObj = [[NSNotificationCenter defaultCenter] addObserverForName:SELECTCARTORBUY object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        if (lastSeleArray_.count != 0) {
            
        } else {
            ZYFFeatureSelectionViewController *dcNewFeaVc = [ZYFFeatureSelectionViewController new];
            dcNewFeaVc.goodImageView = weakSelf.goodImageView;
            [weakSelf setUpAlterViewControllerWith:dcNewFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
        }
    }];
}
#pragma mark ---- UICollectionViewDataSource ----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 6;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 ||section == 2 || section == 3) {
        return 2;
    } else {
        return 1;
    }
}

#pragma mark ---- UICollectionViewDelegate ----
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    DCUserInfo *userInfo = UserInfoData;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DCDetailGoodReferralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailGoodReferralCellID forIndexPath:indexPath];
            
            cell.goodTitleLabel.text = _goodTitle;
            cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %@",_goodPrice];
            cell.goodSubtitleLabel.text = _goodSubtitle;
            [DCSpeedy dc_setUpLabel:cell.goodTitleLabel Content:_goodTitle IndentationFortheFirstLineWith:cell.goodPriceLabel.font.pointSize * 2];
            WEAKSELF
            cell.shareButtonClickBlock = ^{
                //[weakSelf setUpAlterViewControllerWith:[DCShareToViewController new] WithDistance:300 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
            };
            gridcell = cell;
        } else {
            ZYFShowTypeFourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFShowTypeFourCellID forIndexPath:indexPath];
            gridcell = cell;
            
        }
    } else if (indexPath.section == 1 || indexPath.section ==2){
        if (indexPath.section == 1) {
            ZYFShowTypeOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFShowTypeOneCellID forIndexPath:indexPath];
            
            NSString *result = [NSString stringWithFormat:@"%@ %@件",[lastSeleArray_ componentsJoinedByString:@","],lastNum_];
            cell.LeftTitleLabel.text = (lastSeleArray_.count == 0) ? @"点击" :@"已选";
            cell.contentLabel.text = (lastSeleArray_.count == 0) ? @"请选择该商品属性" : result;
            
            gridcell = cell;
        } else {
            if (indexPath.row == 0) {
                ZYFShowTypeTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFShowTypeTwoCellID forIndexPath:indexPath];
                cell.contentLabel.text = (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) ? @"预送地址" : userInfo.defaultAddress;
                gridcell = cell;
            } else {
                ZYFShowTypeThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFShowTypeThreeCellID forIndexPath:indexPath];
                
                gridcell = cell;
            }
        }
    } else if (indexPath.section == 3){
        ZYFDetailServicetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFDetailServicetCellID forIndexPath:indexPath];
        NSArray *btnTitles = @[@"以旧换新",@"可选增值服务"];
        NSArray *btnImages = @[@"detail_xiangqingye_yijiuhuanxin",@"ptgd_icon_zengzhifuwu"];
        NSArray *titles = @[@"以旧换新再送好礼",@"为商品保价护航"];
        [cell.serviceButton setTitle:btnTitles[indexPath.row] forState:(UIControlStateNormal)];
        [cell.serviceButton setImage:[UIImage imageNamed:btnImages[indexPath.row]] forState:(UIControlStateNormal)];
        cell.serviceLabel.text = titles[indexPath.row];
        if (indexPath.row == 0) {//分割线
            [DCSpeedy dc_setUpLongLineWith:cell WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.4] WithHightRatio:0.6];
        }
        gridcell = cell;
        
    }
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *resusalbleview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            DCDetailShufflingHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID forIndexPath:indexPath];
            headerView.shufflingArray = _shufflingArray;
            resusalbleview = headerView;
        }
    } else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        footerView.backgroundColor = DCBGColor;
        resusalbleview = footerView;
    }
    return resusalbleview;
}

/** item **/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CGFloat f1 = [DCSpeedy dc_calculateTextSizeWithText:_goodTitle WithTextFont:16 WithMaxW:ScreenW - DCMargin * 6].height;
            CGFloat f2 = [DCSpeedy dc_calculateTextSizeWithText:_goodPrice WithTextFont:20 WithMaxW:ScreenW - DCMargin * 6].height;
            CGFloat f3 = [DCSpeedy dc_calculateTextSizeWithText:_goodSubtitle WithTextFont:12 WithMaxW:ScreenW - DCMargin * 6].height + DCMargin * 4;
            return CGSizeMake(ScreenW, f1 + f2 + f3);
        } else {
            return CGSizeMake(ScreenW, 35);
        }
    } else if (indexPath.section == 1){
        //商品属性选择
        return CGSizeMake(ScreenW, 60);
    } else if (indexPath.section == 2){
        //商品快递信息
        return CGSizeMake(ScreenW, 60);
    } else if (indexPath.section == 3){
        //商品保价
        return CGSizeMake(ScreenW / 2, 60);
    }
    return CGSizeZero;
}
#pragma mark ---- head宽高 ----
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(ScreenW, ScreenH * 0.55);
    }
    return CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(ScreenW, DCMargin);
}
#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    WEAKSELF
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma 退出界面
- (void)selfAlterViewback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}















































@end
