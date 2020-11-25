//
//  UIViewController+IPhoneTypeHeight.h
//  KingTalent
//
//  Created by 董浩 on 2017/11/6.
//  Copyright © 2017年 yizhilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (IPhoneTypeHeight)
/**
 *  设备底部的高度，iphone X 为 34；非X系列为 0
 */
- (CGFloat)iphoneXBottomSpaceHeight;
/**
 *  设备状态栏的高度
 */
- (CGFloat)iphoneStatusBarHeight;
/**
 *  状态栏(iPhoneX 44) + 导航栏44
 */
- (CGFloat)iphoneXTopHeight;
/**
 *  设备tabbar 的 高度
 */
- (CGFloat)iphoneTabbarHeight;

@end
