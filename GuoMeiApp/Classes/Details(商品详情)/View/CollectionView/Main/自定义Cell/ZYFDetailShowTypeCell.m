//
//  ZYFDetailShowTypeCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFDetailShowTypeCell.h"


@interface ZYFDetailShowTypeCell ()

@end

@implementation ZYFDetailShowTypeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _LeftTitleLabel = [[UILabel alloc] init];
    _LeftTitleLabel.font = PFR14Font;
    _LeftTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_LeftTitleLabel];
    
    _iconImageView = [[UIImageView alloc] init];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = PFR14Font;
    [self addSubview:_contentLabel];
    
    _hintLabel = [[UILabel alloc] init];
    _hintLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_hintLabel];
    
    _indicateButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_indicateButton setImage:[UIImage imageNamed:@"icon_charge_jiantou"] forState:(UIControlStateNormal)];
    _isHasindicateButton = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_LeftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(DCMargin);
        make.top.mas_equalTo(self).mas_offset(DCMargin);
    }];
    
    if (_isHasindicateButton) {
        [self addSubview:_indicateButton];
        [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-DCMargin);
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self);
        }];
    }
    
}

@end
