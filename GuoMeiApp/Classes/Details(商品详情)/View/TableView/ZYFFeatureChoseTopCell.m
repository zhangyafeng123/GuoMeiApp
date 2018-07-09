//
//  ZYFFeatureChoseTopCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/9.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFFeatureChoseTopCell.h"

@interface ZYFFeatureChoseTopCell ()

/** 取消 **/
@property (nonatomic, strong) UIButton *crossButton;
@end

@implementation ZYFFeatureChoseTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setUI
{
    _crossButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_crossButton setImage:[UIImage imageNamed:@"icon_cha"] forState:(UIControlStateNormal)];
    [_crossButton addTarget:self action:@selector(crossButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_crossButton];
    
    _goodImageView = [UIImageView new];
    [self addSubview:_goodImageView];
    
    _goodPriceLabel = [UILabel new];
    _goodPriceLabel.font = PFR18Font;
    _goodPriceLabel.textColor = [UIColor redColor];
    
    [self addSubview:_goodPriceLabel];
    
    _chooseAttLabel = [UILabel new];
    _chooseAttLabel.numberOfLines = 2;
    _chooseAttLabel.font = PFR14Font;
    
    [self addSubview:_chooseAttLabel];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_crossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-DCMargin);
        make.top.mas_equalTo(self).offset(DCMargin);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(DCMargin);
        make.top.mas_equalTo(self).offset(DCMargin);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodImageView.mas_right).offset(DCMargin);
        make.top.mas_equalTo(_goodImageView).offset(DCMargin);
    }];
    [_chooseAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodPriceLabel);
        make.right.mas_equalTo(_crossButton.mas_left);
        make.top.mas_equalTo(_goodPriceLabel.bottom).offset(5);
    }];
}

- (void)crossButtonClick
{
    !_crossButtonClickBlock ?:_crossButtonClickBlock();
}
































@end
