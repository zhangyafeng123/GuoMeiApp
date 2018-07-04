//
//  ZYFFeatureSelectionViewController.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFFeatureSelectionViewController.h"
#import "UIViewController+XWTransition.h"


#define NowScreenH ScreenH * 0.8

@interface ZYFFeatureSelectionViewController ()<UITableViewDelegate,UITableViewDataSource>
/** collectionView **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** tableView **/
@property (nonatomic, strong) UITableView *tableView;
/** 数据 **/


@end

@implementation ZYFFeatureSelectionViewController

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
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
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpFeatureAlterView];
    self.view.backgroundColor = [UIColor redColor];

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





































































@end
