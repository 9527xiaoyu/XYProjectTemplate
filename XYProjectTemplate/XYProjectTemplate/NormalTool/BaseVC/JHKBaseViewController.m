//
//  JHKBaseViewController.m
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import "JHKBaseViewController.h"

@interface JHKBaseViewController ()

@end

@implementation JHKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    //监测到内存警告
    [super didReceiveMemoryWarning];
    if (SYSTEM_VERSION_GREATER_THAN(@"6.0")) {
        if (self.isViewLoaded && !self.view.window)
        {
            self.view = nil;
        }
    }
}

@end
