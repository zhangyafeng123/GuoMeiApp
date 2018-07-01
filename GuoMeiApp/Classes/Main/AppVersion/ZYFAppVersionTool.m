//
//  ZYFAppVersionTool.m
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import "ZYFAppVersionTool.h"

@implementation ZYFAppVersionTool
/**
  获取保存的上一个版本信息
 */
+(NSString *)dc_GetLastOneAppVersion
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}
/**
 保存新版本信息（偏好设置）
 */
+(void)dc_SaveNewAppVersion:(NSString *)version
{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
