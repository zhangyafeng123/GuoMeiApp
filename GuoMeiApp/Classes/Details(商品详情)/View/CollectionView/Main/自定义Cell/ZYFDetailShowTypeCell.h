//
//  ZYFDetailShowTypeCell.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFDetailShowTypeCell : UICollectionViewCell
/** 是否有指示箭头 **/
@property(nonatomic, assign) BOOL isHasindicateButton;
/** 指示按钮 **/
@property (nonatomic, strong) UIButton *indicateButton;
/** 标题 **/
@property (nonatomic, strong) UILabel *LeftTitleLabel;
/** 图片 **/
@property (nonatomic, strong) UIImageView *iconImageView;
/** 内容 **/
@property (nonatomic, strong) UILabel *contentLabel;
/** 提示 **/
@property (nonatomic, strong) UILabel *hintLabel;
@end
