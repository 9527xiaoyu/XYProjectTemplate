//
//  JHKNavigationController.m
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import "JHKNavigationController.h"

@interface JHKNavigationController ()

@end

@implementation JHKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = self;
    }

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }

    [super pushViewController:viewController animated:animated];
}
@end
