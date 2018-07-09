//
//  ZYFFeatureSelectionViewController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFFeatureSelectionViewController.h"
#import "UIViewController+XWTransition.h"
#import "DCFeatureItem.h"
#import "DCFeatureList.h"
#import "DCFeatureItemCell.h"
#import "DCCollectionHeaderLayout.h"
#import "DCFeatureHeaderView.h"
#import "ZYFFeatureChoseTopCell.h"
#import <UIImageView+WebCache.h>
#import <PPNumberButton.h>
#import <SVProgressHUD.h>
#define NowScreenH ScreenH * 0.8

@interface ZYFFeatureSelectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HorizontalCollectionLayoutDelegate,UITableViewDelegate,UITableViewDataSource,PPNumberButtonDelegate>
/** collectionView **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** tableView **/
@property (nonatomic, strong) UITableView *tableView;
/** 数据 **/
@property (strong , nonatomic)NSMutableArray <DCFeatureItem *> *featureAttr;
/** 选择属性 **/
@property (nonatomic, strong) NSMutableArray *seleArray;
/** 商品选择结果Cell **/
@property(nonatomic, weak) ZYFFeatureChoseTopCell *cell;
@end

static NSInteger num_;

static NSString *const DCFeatureHeaderViewID = @"DCFeatureHeaderView";
static NSString *const DCFeatureItemCellID = @"DCFeatureItemCell";
static NSString * const ZYFFeatureChoseTopCellID = @"ZYFFeatureChoseTopCell";


@implementation ZYFFeatureSelectionViewController

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        DCCollectionHeaderLayout *layout = [DCCollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = DCMargin;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        layout.itemInset = UIEdgeInsetsMake(0, DCMargin, 0, DCMargin);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[DCFeatureItemCell class] forCellWithReuseIdentifier:DCFeatureItemCellID];//cell
        [_collectionView registerClass:[DCFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[ZYFFeatureChoseTopCell class] forCellReuseIdentifier:ZYFFeatureChoseTopCellID];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFeatureAlterView];
    [self setUpBase];
    [self setUpBottonView];

}
#pragma mark - 弹出弹框
- (void)setUpFeatureAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    WEAKSELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            //[weakSelf dismissFeatureViewControllerWithTag:100];
        }];
    } edgeSpacing:0];
}

- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    _featureAttr = [DCFeatureItem mj_objectArrayWithFilename:@"ShopItem.plist"]; //数据
    self.tableView.frame = CGRectMake(0, 0, ScreenW, 100);
    self.tableView.rowHeight = 100;
    self.collectionView.frame = CGRectMake(0, self.tableView.dc_bottom ,ScreenW , NowScreenH - 200);
    if (_lastSeleArray.count == 0) return;
    for (NSString *str in _lastSeleArray) {//反向遍历（赋值）
        for (NSInteger i = 0; i < _featureAttr.count; i++) {
            for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
                if ([_featureAttr[i].list[j].infoname isEqualToString:str]) {
                    _featureAttr[i].list[j].isSelect = YES;
                    [self.collectionView reloadData];
                }
            }
        }
    }
}
#pragma mark - 底部按钮
- (void)setUpBottonView
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonH = 50;
    CGFloat buttonW = ScreenW / titles.count;
    CGFloat buttonY = NowScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:titles[i] forState:0];
        buttton.backgroundColor = (i == 0) ? [UIColor redColor] : [UIColor orangeColor];
        CGFloat buttonX = buttonW * i;
        buttton.tag = i;
        buttton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:buttton];
        [buttton addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *numLabel = [UILabel new];
    numLabel.text = @"数量";
    numLabel.font = PFR14Font;
    [self.view addSubview:numLabel];
    numLabel.frame = CGRectMake(DCMargin, NowScreenH - 90, 50, 35);
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(CGRectGetMaxX(numLabel.frame), numLabel.dc_y, 110, numLabel.dc_height)];
    numberButton.shakeAnimation = YES;
    numberButton.minValue = 1;
    numberButton.inputFieldFont = 23;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    num_ = (_lastNum == 0) ?  1 : [_lastNum integerValue];
    numberButton.currentNumber = num_;
    numberButton.delegate = self;
    
//    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
//
//    };
    numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
        num_ = number;
    };
    [self.view addSubview:numberButton];
}
#pragma mark - 底部按钮点击
- (void)buttomButtonClick:(UIButton *)button
{
    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {//未选择全属性警告
        [SVProgressHUD showInfoWithStatus:@"请选择全属性"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    [self dismissFeatureViewControllerWithTag:button.tag];
    
}

/**
 加减代理回调
 
 @param numberButton 按钮
 @param number 结果
 @param increaseStatus 是否为加状态
 */
- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus
{
    
}
#pragma mark ---- tableviewDelegate ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYFFeatureChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:ZYFFeatureChoseTopCellID forIndexPath:indexPath];
    _cell = cell;
    if (_seleArray.count != _featureAttr.count && _lastSeleArray.count != _featureAttr.count) {
        cell.chooseAttLabel.textColor = [UIColor redColor];
        cell.chooseAttLabel.text = @"有货";
    }else {
        cell.chooseAttLabel.textColor = [UIColor darkGrayColor];
        NSString *attString = (_seleArray.count == _featureAttr.count) ? [_seleArray componentsJoinedByString:@"，"] : [_lastSeleArray componentsJoinedByString:@"，"];
        cell.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",attString];
    }
    
    cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %@",@"12"];
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageView]];
    WEAKSELF
    cell.crossButtonClickBlock = ^{
        [weakSelf dismissFeatureViewControllerWithTag:100];
    };
    return cell;
}
#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag
{
    WEAKSELF
    [weakSelf dismissViewControllerAnimated:YES completion:^{
        if (![weakSelf.cell.chooseAttLabel.text isEqualToString:@"有货"]) {//当选择全属性才传递出去
            
            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                if (weakSelf.seleArray.count == 0) {
                    NSMutableArray *numArray = [NSMutableArray arrayWithArray:weakSelf.lastSeleArray];
                    NSDictionary *paDict = @{
                                             @"Tag" : [NSString stringWithFormat:@"%zd",tag],
                                             @"Num" : [NSString stringWithFormat:@"%zd",num_],
                                             @"Array" : numArray
                                             };
                    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:paDict];
                    [[NSNotificationCenter defaultCenter]postNotificationName:SHOPITEMSELECTBACK object:nil userInfo:dict];
                }else{
                    NSDictionary *paDict = @{
                                             @"Tag" : [NSString stringWithFormat:@"%zd",tag],
                                             @"Num" : [NSString stringWithFormat:@"%zd",num_],
                                             @"Array" : weakSelf.seleArray
                                             };
                    NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:paDict];
                    [[NSNotificationCenter defaultCenter]postNotificationName:SHOPITEMSELECTBACK object:nil userInfo:dict];
                }
            });
        }
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _featureAttr[section].list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DCFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCFeatureItemCellID forIndexPath:indexPath];
    cell.content = _featureAttr[indexPath.section].list[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        DCFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID forIndexPath:indexPath];
        headerView.headTitle = _featureAttr[indexPath.section].attr;
        return headerView;
    }else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //限制每组内的Item只能选中一个(加入质数选择)
    if (_featureAttr[indexPath.section].list[indexPath.row].isSelect == NO) {
        for (NSInteger j = 0; j < _featureAttr[indexPath.section].list.count; j++) {
            _featureAttr[indexPath.section].list[j].isSelect = NO;
        }
    }
    _featureAttr[indexPath.section].list[indexPath.row].isSelect = !_featureAttr[indexPath.section].list[indexPath.row].isSelect;
    
    
    //section，item 循环讲选中的所有Item加入数组中 ，数组mutableCopy初始化
    _seleArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < _featureAttr.count; i++) {
        for (NSInteger j = 0; j < _featureAttr[i].list.count; j++) {
            if (_featureAttr[i].list[j].isSelect == YES) {
                [_seleArray addObject:_featureAttr[i].list[j].infoname];
            }else{
                [_seleArray removeObject:_featureAttr[i].list[j].infoname];
                [_lastSeleArray removeAllObjects];
            }
        }
    }
    
    //刷新tableView和collectionView
    [self.collectionView reloadData];
    [self.tableView reloadData];
}


#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    return _featureAttr[indexPath.section].list[indexPath.row].infoname;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

































































@end
