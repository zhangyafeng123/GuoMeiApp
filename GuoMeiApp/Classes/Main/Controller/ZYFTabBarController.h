//
//  ZYFTabBarController.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZYFTabBarControllerType) {
    ZYFabBarControllerMeiXin = 0,  //美信
    ZYFabBarControllerHome = 1, //首页
    ZYFabBarControllerMediaList = 2,  //美媚榜
    ZYFabBarControllerBeautyStore = 3, //美店
    ZYFabBarControllerPerson = 4, //个人中心
};


@interface ZYFTabBarController : UITabBarController
/** 控制器type **/
@property(nonatomic, assign) ZYFTabBarControllerType tabVcType;

@end
