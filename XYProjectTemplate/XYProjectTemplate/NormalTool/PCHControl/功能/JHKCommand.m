//
//  JHKCommand.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKCommand.h"
#import "AppDelegate.h"
#import "NSString+JHKURL.h"

@interface JHKCommand()
@property (nonatomic,strong,readwrite) NSString *command;
@property (nonatomic,strong,readwrite) NSString *body;
@property (nonatomic,strong,readwrite) NSString *urlArg;
@property (nonatomic,strong,readwrite) NSDictionary *params;


@end
@implementation JHKCommand
- (instancetype)initWithCommand:(NSString *)command
{
    self = [super init];
    if (self) {
        _command = command;
        _params = [command getAllParameterDict];
        _body = [command getUrlBody];
        _urlArg = [command getUrlArg];
        if (!_urlArg) {
            _urlArg = @"";
        }
    }
    return self;
}

+ (BOOL)couldParse:(NSString *)commandString
{
    return NO;
}

- (void)execute{}

- (BOOL)havaParam:(NSString *)param
{
    if ([self.params.allKeys containsObject:param]) {
        return YES;
    }
    return NO;
}

- (id)valueWithParam:(NSString *)param
{
    return self.params[param];
}

- (void)showListView:(NSArray *)dataSource
{
    UIWindow *window = jhkAppDelegate.window;
    NSInteger tag = 4270;
    
    UIView *view = [window viewWithTag:tag];
    CGRect frame = view.frame;
    if (view) {
        [view removeFromSuperview];
    }else{
        CGSize size = window.frame.size;
        
        CGFloat width = size.width * 0.8;
        CGFloat height = size.height * 0.6;
        CGFloat x = size.width * 0.1;
        CGFloat y = size.height * 0.2;
        
        frame = CGRectMake(x,y,width,height);
    }
    
//    ListView *listView = [[ListView alloc] initWithFrame:frame];
//    listView.tag = tag;
//    listView.dataSources = dataSource;
//    [window addSubview:listView];
}
@end
