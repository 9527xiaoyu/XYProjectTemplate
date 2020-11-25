//
//  AppDelegate.m
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import "AppDelegate.h"
#import "JHKTabBarController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    JHKTabBarController *mainVC = [[JHKTabBarController alloc]init];
    mainVC.view.backgroundColor = UIColor.whiteColor;
    mainVC.delegate = self;
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - ==================== UITabBarControllerDelegate ============================
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
     return YES;
}

@end
