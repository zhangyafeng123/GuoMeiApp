//
//  ZYFGoodsGridCell.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/1.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFGoodsGridCell.h"
#import "ZYFGridItem.h"
#import <UIImageView+WebCache.h>

@interface ZYFGoodsGridCell ()
/** imageView **/
@property (nonatomic, strong) UIImageView *gridImageView;
/** gridLabel **/
@property (nonatomic, strong) UILabel *gridLabel;
/** tagLabel **/
@property (nonatomic, strong) UILabel *tagLabel;
@end

@implementation ZYFGoodsGridCell
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
    _gridImageView = [[UIImageView alloc] init];
    /** 会保证图片比例不变，但是是填充整个ImageView的，可能只有部分图片显示出来 **/
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR13Font;
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:8];
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tagLabel];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(DCMargin);
        if (iphone5) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
        } else {
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }
        make.centerX.mas_equalTo(self);
    }];
    /** 不用定义宽高,按照字体进行自适应 **/
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self->_gridImageView.mas_bottom).offset(5);
    }];
    
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_gridImageView.mas_centerX);
        make.top.mas_equalTo(self->_gridImageView);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
}

#pragma mark ---- Setter Getter Methods ----
-(void)setGridItem:(ZYFGridItem *)gridItem
{
    _gridItem = gridItem;
    
    
    _gridLabel.text = gridItem.gridTitle;
    _tagLabel.text = gridItem.gridTag;
    
    _tagLabel.hidden = (gridItem.gridTag.length == 0) ? YES : NO;
    _tagLabel.textColor = [UIColor dc_colorWithHexString:gridItem.gridColor];
    [DCSpeedy dc_chageControlCircularWith:_tagLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:_tagLabel.textColor canMasksToBounds:YES];
    
    if (_gridItem.iconImage.length == 0) return;
    if ([[_gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:_gridItem.iconImage];
    }
}

@end
