//
//  UIView+JHKViewController.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JHKViewController)

//使视图可以寻找到自己的所在控制器
- (UIViewController *)viewController;

//寻找当前视图中的第一响应者
- (UIView *)findFirstResponder;


@end

NS_ASSUME_NONNULL_END
