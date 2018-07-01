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
@interface ZYFHandPickViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** collectionView **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 10个属性 **/
@property (nonatomic, strong) NSMutableArray<ZYFGridItem *> *gridItem;
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
    
    
    [self setUpGoodsData];
    
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



















@end
