//
//  UIColor+ZYFColorChange.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/1.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZYFColorChange)
#pragma mark - 十六进制颜色
+ (UIColor *)dc_colorWithHexString:(NSString *)color;
@end
