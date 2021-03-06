//
//  Headers.h
//  YKC好了吗客户端
//
//  Created by Insect on 2017/1/5.
//  Copyright © 2017年 Insect. All rights reserved.
//

#ifndef Headers_h
#define Headers_h

#import "DCConsts.h" // 常量
#import "Macros.h" // 宏
#import <CDDPagerController/UIView+DCPagerFrame.h>


// 定义这个常量，就可以不用在开发过程中使用"mas_"前缀。
#define MAS_SHORTHAND
// 定义这个常量，就可以让Masonry帮我们自动把基础数据类型的数据，自动装箱为对象类型。
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>
#import <MJExtension.h>
#import "DCSpeedy.h" //便捷方法
//#import "DCUserInfo.h" //本地数据个人中心数据
#import "UIView+DCExtension.h" // UIView分类
#import "DCObjManager.h"  //存取
#import "DCNotificationCenterName.h" //通知
#import "UIColor+ZYFColorChange.h"
#import "UIBarButtonItem+DCBarButtonItem.h"
//#import <Foundation/Foundation.h>
//#import <UIKit/UIKit.h>

#endif /* Headers_h */
