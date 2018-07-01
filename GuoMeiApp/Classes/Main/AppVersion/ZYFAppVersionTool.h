//
//  ZYFAppVersionTool.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYFAppVersionTool : NSObject
/**
 获取之前保存的版本
 */
+(NSString *)dc_GetLastOneAppVersion;
/**
 保存新版本
 */
+(void)dc_SaveNewAppVersion:(NSString *)version;
@end
