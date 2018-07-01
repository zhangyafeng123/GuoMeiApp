//
//  ZYFHomeTopToolView.h
//  GuoMeiApp
//
//  Created by linjianguo on 2018/7/1.
//  Copyright © 2018年 com.justsee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFHomeTopToolView : UIView
/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 右边第二个Item点击 */
@property (nonatomic, copy) dispatch_block_t rightRItemClickBlock;

/** 搜索按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t searchButtonClickBlock;
/** 语音按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t voiceButtonClickBlock;
@end
