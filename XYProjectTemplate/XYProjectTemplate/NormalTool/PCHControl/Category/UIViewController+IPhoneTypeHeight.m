//
//  UIViewController+IPhoneTypeHeight.m
//  KingTalent
//
//  Created by 董浩 on 2017/11/6.
//  Copyright © 2017年 yizhilu. All rights reserved.
//

#import "UIViewController+IPhoneTypeHeight.h"
#import "JHKiPhoneScreenTool.h"

@implementation UIViewController (IPhoneTypeHeight)

- (CGFloat)iphoneXBottomSpaceHeight {
    /// 底部的高度
    if ([JHKiPhoneScreenTool JHKDeviceVersionIsIphoneX] == YES) {
        return 34;
    }
    return 0;
}

- (CGFloat)iphoneTabbarHeight {
    return self.tabBarController.tabBar.frame.size.height;
}

- (CGFloat)iphoneStatusBarHeight {
    
    if ([JHKiPhoneScreenTool JHKDeviceVersionIsIphoneX] == YES) {
        return 44;
    }
    return 20;
}


- (CGFloat)iphoneXTopHeight {
    ///标题栏 === 用到了 导航控制器
    return [JHKiPhoneScreenTool JHKiphoneTopHeight];;
    
}
@end
