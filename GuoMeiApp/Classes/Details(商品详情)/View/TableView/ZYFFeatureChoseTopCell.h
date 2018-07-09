//
//  ZYFFeatureChoseTopCell.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/9.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFFeatureChoseTopCell : UITableViewCell
/** 取消点击回调 **/
@property(nonatomic, copy) dispatch_block_t crossButtonClickBlock;
/** 商品价格 **/
@property (nonatomic, strong) UILabel *goodPriceLabel;
/** 图片 **/
@property (nonatomic, strong) UIImageView *goodImageView;
/** 选择属性 **/
@property (nonatomic, strong) UILabel *chooseAttLabel;
@end
