//
//  ZYFGoodBaseViewController.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/3.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFGoodBaseViewController : UIViewController
/** 更改标题 **/
@property(nonatomic, copy) void(^changeTitleBlock)(BOOL isChange);
/** 商品标题 **/
@property (nonatomic, strong) NSString *goodTitle;
/** 商品价格 **/
@property (nonatomic, strong) NSString *goodPrice;
/** 商品小标题 **/
@property (nonatomic, strong) NSString *goodSubtitle;
/** 商品图片 **/
@property (nonatomic, strong) NSString *goodImageView;
/** 商品轮播图 **/
@property(nonatomic, copy) NSArray *shufflingArray;

























@end
