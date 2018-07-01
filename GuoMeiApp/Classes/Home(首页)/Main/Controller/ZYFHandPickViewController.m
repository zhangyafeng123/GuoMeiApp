//
//  ZYFHandPickViewController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/1.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFHandPickViewController.h"
#import "ZYFGridItem.h"
#import "ZYFGoodsGridCell.h"
#import "ZYFSlideshowHeadView.h"
#import "ZYFHomeTopToolView.h"
@interface ZYFHandPickViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** collectionView **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 10个属性 **/
@property (nonatomic, strong) NSMutableArray<ZYFGridItem *> *gridItem;
/** 顶部工具栏 **/
@property (nonatomic, strong) ZYFHomeTopToolView *topToolView;
/** 滚回顶部按钮 **/
@property (nonatomic, strong) UIButton *backTopButton;
@end

@implementation ZYFHandPickViewController
/** cell **/
static NSString *const ZYFGoodsGridCellID = @"ZYFGoodsGridCell";
/** header **/
static NSString *const ZYFSlideshowHeadViewID = @"ZYFSlideshowHeadView";
/** footer **/
#pragma mark ---- lazy ----
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        /** cell **/
        [_collectionView registerClass:[ZYFGoodsGridCell class] forCellWithReuseIdentifier:ZYFGoodsGridCellID];
        
        /** header **/
        [_collectionView registerClass:[ZYFSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZYFSlideshowHeadViewID];
        /** footer **/
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpNavTopView];
    
    [self setUpGoodsData];
    
    [self setUpScrollToTopView];
    
}
#pragma mark ---- init ----
- (void)setUpBase
{
    self.collectionView.backgroundColor = DCBGColor;
    /** 设置为白色 **/
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [ZYFGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    //_youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}
#pragma mark ---- 导航栏处理 ----
- (void)setUpNavTopView
{
    _topToolView = [[ZYFHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    WEAKSELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了首页扫一扫");
//        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
//        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了首页分类");
//        DCCommodityViewController *dcComVc = [DCCommodityViewController new];
//        [weakSelf.navigationController pushViewController:dcComVc animated:YES];
    };
    _topToolView.rightRItemClickBlock = ^{
        NSLog(@"点击了首页购物车");
//        DCMyTrolleyViewController *shopCarVc = [DCMyTrolleyViewController new];
//        shopCarVc.isTabBar = YES;
//        shopCarVc.title = @"购物车";
//        [weakSelf.navigationController pushViewController:shopCarVc animated:YES];
    };
    _topToolView.searchButtonClickBlock = ^{
        NSLog(@"点击了首页搜索");
    };
    _topToolView.voiceButtonClickBlock = ^{
        NSLog(@"点击了首页语音");
    };
    [self.view addSubview:_topToolView];
}
#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 110, 40, 40);
}
#pragma mark ---- UICollectionViewDataSource ----

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        //10属性
        return _gridItem.count;
    } else {
        return 0;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {
        ZYFGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *resuableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            ZYFSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ZYFSlideshowHeadViewID forIndexPath:indexPath];
            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
            resuableview = headerView;
            
        }
    }
    return resuableview;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //9宫格
        return CGSizeMake(ScreenW/5, ScreenW/5 + DCMargin);
    } else {
        return CGSizeZero;
    }
}

#pragma mark ---- header宽高 ----
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(ScreenW, 230);//图片滚动的宽高
    }
    
    return CGSizeZero;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 5) ? 4 : 0;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DCNaviH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}
#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}















@end
