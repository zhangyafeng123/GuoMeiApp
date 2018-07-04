//
//  ZYFShowTypeOneCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFShowTypeOneCell.h"

@implementation ZYFShowTypeOneCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpData];
    }
    return self;
}
- (void)setUpData
{
    self.hintLabel.text = @"可选增值服务";
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.hintLabel.font = PFR12Font;
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.LeftTitleLabel.mas_right).mas_offset(DCMargin);
        make.width.mas_equalTo(self).multipliedBy(0.78);//乘以
        make.centerY.mas_equalTo(self.LeftTitleLabel);
    }];
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentLabel);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(8);
    }];
}

@end
