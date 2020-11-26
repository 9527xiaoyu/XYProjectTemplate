//
//  NextViewController.m
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import "NextViewController.h"
#import "SecondViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = nC10_FFFFFF_white;
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setBackgroundColor: nC2_000000_black];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (void)buttonClick
{
    SecondViewController *viewC = [[SecondViewController alloc]init];
    [self pushViewController:viewC style:GXAnimationStylePushAllLeft interacting:YES];
}


- (void)dealloc
{
    jhkLog(@"释放上一级VC");
}

@end
