//
//  ZYFFeatureSelectionViewController.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFFeatureSelectionViewController : UIViewController
/** 商品图片 **/
@property (nonatomic, strong) NSString *goodImageView;
/** 上一次选择的属性 **/
@property (nonatomic, strong) NSMutableArray *lastSeleArray;
/** 上一次选择的数量 **/
@property(nonatomic, copy) NSString *lastNum;
@end
