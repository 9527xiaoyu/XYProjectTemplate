//
//  JHKTabBarController.m
//  XYProjectTemplate
//
//  Created by 杨晓宇 on 2020/11/25.
//

#import "JHKTabBarController.h"
#import "NextViewController.h"
#import "JHKNavigationController.h"

@interface JHKTabBarController ()

@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *selectImageArray;
@property (nonatomic, strong) NSMutableArray *viewControllerArray;
@property (nonatomic) BOOL isViewAppear;

@end

@implementation JHKTabBarController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.isViewAppear = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewController];
    for (NSUInteger i = 0; i < self.viewControllerArray.count; i ++) {
        NSString *nextVCString = self.viewControllerArray[i];
        
        UIViewController *nextVC =[NSClassFromString(nextVCString) new];

        UIImage *norMalImage = [UIImage imageNamed:self.imageArray[i]];
        UIImage *selectImage = [UIImage imageNamed:self.selectImageArray[i]];
        
        norMalImage = [norMalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildVC:nextVC title:self.titleArray[i] normalImage:norMalImage selectedImage:selectImage];
    }
}

- (void)setupChildViewController
{

    self.titleArray = [NSMutableArray arrayWithArray:@[@"首页", @"题库", @"上课",@"社区", @"我的"]];
   self.imageArray = [NSMutableArray arrayWithArray:@[@"首页未点击", @"tabbar题库未点击",@"时间未点击", @"社区未点击", @"我的未点击"]];
    self.selectImageArray = [NSMutableArray arrayWithArray:@[@"首页选中", @"tabbar题库选中",@"时间选中", @"社区选中", @"我的选中"]];

    self.viewControllerArray = [NSMutableArray arrayWithArray:@[@"NextViewController", @"NextViewController", @"NextViewController",@"NextViewController", @"NextViewController"]];
}

- (void)addChildVC:(UIViewController *)viewController title:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage {
    //同时设置tabbar  和 navigationBar 的文字
    viewController.title = title;
    // 设置子控制器的图片
    viewController.tabBarItem.image = normalImage;
    //设置tabBarItem 的 imageWithRenderingMode 才能显示自定义的图片
    viewController.tabBarItem.selectedImage = selectedImage;
    //设置文字样式
    JHKNavigationController *mainNavi = [[JHKNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:mainNavi];
}

#pragma mark - ==================== 点击事件 ============================
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.title.length == 0) {
        NSInteger index = [tabBar.items indexOfObject:item];
        JHKNavigationController *navc = [self.childViewControllers objectAtIndex:index];
    }
    
    if (item == tabBar.items.lastObject) {
        JHKNavigationController *navc = self.childViewControllers.lastObject;
//        [vc.tabBarItem clearBadge];
    }else if (item == tabBar.items[2]){
        JHKNavigationController *navc = self.childViewControllers[2];
        
    }else if (item == tabBar.items[3]){
        JHKNavigationController *navc = self.childViewControllers[3];
    }
    
}

#define BASE_BADGE_TAG    1000
#define BADGE_VIEW_WIDTH  18.0
#define BADGE_VIEW_HEIGHT 18.0
- (void)showBarBadgeOnItemIndex:(NSInteger)index value:(NSInteger)count
{
    NSInteger itemCount = [self.tabBar.items count];
    if (index < 0 || index > (itemCount - 1)) {
        return;
    }
    
    //移除之前的小红点
    if (count == 0) {
        [self removeBadgeOnItemIndex:index];
        return;
    }
    
    NSInteger badgeTag = (BASE_BADGE_TAG + index);
    UILabel *badgeLabel = [self.tabBar viewWithTag:badgeTag];
    if (badgeLabel == nil) {
        //新建小红点
        badgeLabel = [[UILabel alloc] init];
        [badgeLabel setBackgroundColor:[UIColor redColor]];
        [badgeLabel setTextColor:[UIColor whiteColor]];
        [badgeLabel setTextAlignment:NSTextAlignmentCenter];
        [badgeLabel.layer setCornerRadius:BADGE_VIEW_WIDTH/2];
        [badgeLabel.layer setMasksToBounds:YES];
        [badgeLabel setClipsToBounds:YES];
        
        //确定小红点的位置
        NSMutableArray *arrLocationX = [NSMutableArray arrayWithCapacity:10];
        for (UIView *subView in self.tabBar.subviews) {
            
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                NSInteger location = ceil(CGRectGetMidX(subView.frame));
                [arrLocationX addObject:[NSNumber numberWithInteger:location]];
            }
        }
        
        NSComparator cmptr = ^(id obj1, id obj2){
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        };
        NSArray *arrayLocationSorted = [arrLocationX sortedArrayUsingComparator:cmptr];
        
        // 给 x y 一个估算值，防止因官方视图UITabBarButton 修改而无法遍历到
        CGFloat offset = 0.45f;
        NSInteger spaceCount = itemCount;
        CGSize tabbarSize = self.tabBar.bounds.size;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            offset = 1.45f;
            spaceCount = (itemCount + 2);
        }
        CGFloat spaceWidth = (tabbarSize.width/spaceCount);
        
        //估算赋值
        CGFloat y = ceil(0.1 * tabbarSize.height);
        CGFloat x = ceil((offset + (index + 0.1)) * spaceWidth);
        if (itemCount == [arrayLocationSorted count]) {
            //准确赋值
            NSNumber *locationX = [arrayLocationSorted objectAtIndex:index];
            x = locationX.integerValue + 1.0;
        }
        
        [badgeLabel setFrame:CGRectMake(x, y, BADGE_VIEW_WIDTH, BADGE_VIEW_HEIGHT)];
        [badgeLabel setTag:badgeTag];
        [self.tabBar addSubview:badgeLabel];
    }
    
    if (count > 99) {
        [badgeLabel setFont:[UIFont systemFontOfSize:9]];
        [badgeLabel setText:@"99+"];
    }
    else {
        [badgeLabel setFont:[UIFont systemFontOfSize:12]];
        [badgeLabel setText:[NSString stringWithFormat:@"%ld", (long)count]];
    }
}

- (void)hideBadgeOnItemIndex:(NSInteger)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    //按照tag值进行移除
    for (UIView *subView in self.tabBar.subviews) {
        
        if (subView.tag == (BASE_BADGE_TAG + index)) {
            [subView removeFromSuperview];
        }
    }
}

@end
