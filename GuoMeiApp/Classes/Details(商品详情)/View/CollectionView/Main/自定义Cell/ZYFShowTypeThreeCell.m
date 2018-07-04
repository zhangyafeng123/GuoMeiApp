//
//  ZYFShowTypeThreeCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFShowTypeThreeCell.h"

@implementation ZYFShowTypeThreeCell

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
    self.isHasindicateButton = NO;
    self.LeftTitleLabel.text = @"运费";
    self.contentLabel.text = @"免运费";
    self.hintLabel.text = @"支持7天无理由退货";
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.hintLabel.font = PFR10Font;
    [self addSubview:self.iconImageView];
    self.iconImageView.image = [UIImage imageNamed:@"icon_duigou_small"];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.LeftTitleLabel.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.LeftTitleLabel);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.LeftTitleLabel);
        [make.top.mas_equalTo(self.LeftTitleLabel.mas_bottom)setOffset:DCMargin];
    }];
    
    [self.hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.iconImageView.mas_right)setOffset:DCMargin];
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    
}

@end
