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
@interface ZYFGoodBaseViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WKWebView *webView;
@end
/** cell **/
static NSString * const DCDetailGoodReferralCellID = @"DCDetailGoodReferralCell";
/** header **/
static NSString * const DCDetailShufflingHeadViewID = @"DCDetailShufflingHeadView";



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
        /** header **/
        [_collectionView registerClass:[DCDetailShufflingHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCDetailShufflingHeadViewID];
        
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

}
#pragma mark ---- init ----
- (void)setUpInit
{
    self.view.backgroundColor = DCBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    //初始化
    
}

#pragma mark ---- UICollectionViewDataSource ----
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark ---- UICollectionViewDelegate ----
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    
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
        }
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
    return CGSizeZero;
}



















































@end
