//
//  ZYFShowTypeTwoCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFShowTypeTwoCell.h"

@implementation ZYFShowTypeTwoCell
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
    self.LeftTitleLabel.text = @"送至";
    self.hintLabel.text = @"由ZYF商贸配送监管";
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.hintLabel.font = PFR12Font;
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"ptgd_icon_dizhi"];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.LeftTitleLabel.right).offset(DCMargin);
        make.centerY.mas_equalTo(self.LeftTitleLabel);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(DCMargin);
        make.centerY.mas_equalTo(self.LeftTitleLabel);
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImageView);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(8);
    }];
    
}
@end
