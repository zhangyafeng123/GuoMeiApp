//
//  ZYFZuoWenRightButton.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/3.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFZuoWenRightButton.h"

@interface ZYFZuoWenRightButton ()

@end


@implementation ZYFZuoWenRightButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置label
    self.titleLabel.dc_x = 0;
    self.titleLabel.dc_centerY = self.dc_centerY;
    [self.titleLabel sizeToFit];
    //设置图片位置
    self.imageView.dc_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.dc_centerY = self.dc_centerY;
    [self.imageView sizeToFit];
}
























@end
