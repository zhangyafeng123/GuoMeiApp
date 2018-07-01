//
//  ZYFFeatureCell.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/1.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFFeatureCell : UICollectionViewCell
/* imageView */
@property (strong , nonatomic)UIImageView *nfImageView;

/** 隐藏新特性按钮点击回调 */
@property (nonatomic, copy) dispatch_block_t hideButtonClickBlock;

/* 跳过图片素材 */
@property (strong , nonatomic)NSString *hideBtnImg;

/**
 用来获取页码
 
 @param currentIndex 当前index
 @param lastIndex 最后index
 */
- (void)dc_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex;
@end
