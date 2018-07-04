//
//  ZYFExceedApplianceCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/3.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFExceedApplianceCell.h"

#import "DCGoodsHandheldCell.h"
#import <UIImageView+WebCache.h>


@interface ZYFExceedApplianceCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
/** 头部ImageView **/
@property (nonatomic, strong) UIImageView *headImageView;
/** 图片数组 **/
@property(nonatomic, copy) NSArray *imagesArray;
@end

static NSString * const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";

@implementation ZYFExceedApplianceCell
#pragma mark ---- lazy ----
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(100, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = CGRectMake(0, ScreenW * 0.35 + DCMargin, ScreenW, 100);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
    }
    return _collectionView;
}
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
    
    _headImageView = [[UIImageView alloc] init];
    [self addSubview:_headImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(ScreenW * 0.32);
    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imagesArray.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
    cell.handheldImage = _imagesArray[indexPath.row + 1];
    return cell;
}

- (void)setGoodExceedArray:(NSArray *)goodExceedArray
{
    _goodExceedArray = goodExceedArray;
    _imagesArray = goodExceedArray;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
}































































@end
