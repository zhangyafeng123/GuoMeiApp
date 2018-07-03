//
//  ZYFGoodsCountDownCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/3.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFGoodsCountDownCell.h"
#import "ZYFRecommendItem.h"
#import "DCGoodsSurplusCell.h"
@interface ZYFGoodsCountDownCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/** collection **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 推荐商品数据 **/
@property (nonatomic, strong) NSMutableArray<ZYFRecommendItem *> *countDownItem;
/** 底部 **/
@property (nonatomic, strong) UIView *bottomLineView;
@end

static NSString *const ZYFGoodsSurplusCellID = @"DCGoodsSurplusCell";

@implementation ZYFGoodsCountDownCell
#pragma mark ---- lazyload ----
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(self.dc_height * 0.65, self.dc_height * 0.9);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DCGoodsSurplusCell class] forCellWithReuseIdentifier:ZYFGoodsSurplusCellID];
    }
    return _collectionView;
}
-(NSMutableArray<ZYFRecommendItem *> *)countDownItem
{
    if (!_countDownItem) {
        _countDownItem  = [NSMutableArray new];
    }
    return _countDownItem;
}

#pragma mark ---- init ----

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    NSArray *countDownArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CountDownShop.plist" ofType:nil]];
    _countDownItem = [ZYFRecommendItem mj_objectArrayWithKeyValuesArray:countDownArray];
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = DCBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.dc_height - 8, ScreenW, 8);
    
}
#pragma mark ---- 布局 ----
-(void)layoutSubviews
{
    [super layoutSubviews];
}
#pragma mark ---- UICollectionViewDataSource ----
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _countDownItem.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCGoodsSurplusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZYFGoodsSurplusCellID forIndexPath:indexPath];
    cell.recommendItem = _countDownItem[indexPath.row];
    return cell;
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了计时商品%zd",indexPath.row);
    
}















































@end
