//
//  SecondViewController.m
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/26.
//

#import "SecondViewController.h"
#import "ThreaViewController.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = nC10_FFFFFF_white;
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setBackgroundColor: nC2_000000_black];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.center = self.view.center;
    [self.view addSubview:button];
    [self addReturnButton];
}

- (void)buttonClick
{
    ThreaViewController *viewC = [[ThreaViewController alloc]init];
    [self.navigationController pushViewController:viewC animated:YES];
}


- (void)dealloc
{
    jhkLog(@"释放上一级SecondViewController");
}


@end
