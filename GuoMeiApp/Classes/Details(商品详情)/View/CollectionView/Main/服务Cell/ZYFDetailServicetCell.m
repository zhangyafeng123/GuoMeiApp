//
//  ZYFDetailServicetCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/4.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFDetailServicetCell.h"

@implementation ZYFDetailServicetCell

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
    _serviceButton = [[DCLIRLButton alloc] init];
    [_serviceButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _serviceButton.titleLabel.font = PFR13Font;
    [self addSubview:_serviceButton];
    
    _serviceLabel = [[UILabel alloc] init];
    _serviceLabel.textColor = [UIColor lightGrayColor];
    _serviceLabel.font = PFR12Font;
    _serviceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_serviceLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_centerY).mas_offset(3);
        make.centerX.mas_equalTo(self);
    }];
    
    [_serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_serviceButton.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(self);
    }];
}

























@end
