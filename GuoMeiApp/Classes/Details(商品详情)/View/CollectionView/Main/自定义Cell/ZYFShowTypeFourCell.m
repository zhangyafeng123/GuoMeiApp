//
//  ZYFShowTypeFourCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFShowTypeFourCell.h"

@implementation ZYFShowTypeFourCell

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
    self.LeftTitleLabel.text = @"领券";
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"biaoqian"];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //重写LeftTitleLabelFrame
    [self.LeftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(DCMargin);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.LeftTitleLabel.mas_right).mas_offset(DCMargin);
        make.centerY.mas_equalTo(self.LeftTitleLabel);
    }];
    
    
    
}
@end
