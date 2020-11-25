//
//  JHKTerminal.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKTerminal.h"
#import "JHKCommand.h"

@implementation JHKTerminal

static JHKTerminal *_instance;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedTerminal
{
    if (_instance == nil) {
        _instance = [[JHKTerminal alloc] init];
    }
    return _instance;
}

- (BOOL)couldParse:(NSString *)commandString
{
    if (![commandString hasContainString:@"://"]) {
        return NO;
    }
    NSArray *components = [commandString componentsSeparatedByString:@"://"];
    if (components.count < 2) {
        return NO;
    }
    if (![[components[0] lowercaseString] hasPrefix:@"jhk"]) {
        return NO;
    }
    
    NSRange range = NSMakeRange(0, 7);
    commandString = [commandString stringByReplacingCharactersInRange:range withString:@""];
    
    NSArray<NSString *> *commmandClzs = [JHKTerminal allCommands];
    for (NSString *commandClzStr in commmandClzs) {
        id commandClass = NSClassFromString(commandClzStr);
        if ([commandClass couldParse:commandString]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)parse:(NSString *)commandString
{
    if (![commandString hasContainString:@"://"]) {
        return;
    }
    NSArray *components = [commandString componentsSeparatedByString:@"://"];
    if (components.count < 2) {
        return;
    }
    if (![[components[0] lowercaseString] hasPrefix:@"jhk"]) {
        return;
    }
    
    NSRange range = NSMakeRange(0, 7);
    commandString = [commandString stringByReplacingCharactersInRange:range withString:@""];
    
    commandString = [commandString paramUrlEncoded];
    
    JHKCommand *command;
    NSArray<NSString *> *commmandClzs = [JHKTerminal allCommands];
    for (NSString *commandClzStr in commmandClzs) {
        id commandClass = NSClassFromString(commandClzStr);
        if ([commandClass couldParse:commandString]) {
            command = [[commandClass alloc] initWithCommand:commandString];
            break;
        }
    }
    [command execute];
}

+ (NSArray<NSString *> *)allCommands
{
    return @[@"DebugCommand",@"RouteCommand",@"RevealCommand",@"UserCommand",@"ConfigCommand",@"NetworkCommand",@"VipCommand",@"AlertCommand",@"NotifyCommand",@"SearchHistoryCountCommand",@"ClsCommand",@"LogoutCommand",@"TestCommand",@"ExitCommand"];
}
@end
