//
//  ZYFDetailServicetCell.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCLIRLButton.h"
@interface ZYFDetailServicetCell : UICollectionViewCell

/** 服务按钮 **/
@property (nonatomic, strong) DCLIRLButton *serviceButton;
/** 服务标题 **/
@property (nonatomic, strong) UILabel *serviceLabel;
@end
