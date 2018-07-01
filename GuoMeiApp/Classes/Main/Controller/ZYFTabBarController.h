//
//  ZYFTabBarController.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/6/30.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZYFTabBarControllerType) {
    ZYFtabBarControllerMeiXin = 0,  //美信
    ZYFtabBarControllerHome = 1, //首页
    ZYFtabBarControllerMediaList = 2,  //美媚榜
    ZYFtabBarControllerBeautyStore = 3, //美店
    ZYFtabBarControllerPerson = 4, //个人中心
};


@interface ZYFTabBarController : UITabBarController
/** 控制器type **/
@property(nonatomic, assign) ZYFTabBarControllerType tabVcType;

@end
