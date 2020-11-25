//
//  JHKThemeManager.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#ifndef _SYSTEMCONFIGURATION_H
#error  You should include the `SystemConfiguration` framework and \
add `#import <SystemConfiguration/SystemConfiguration.h>`\
to the header prefix.
#endif

#ifdef _SYSTEMCONFIGURATION_H
extern NSString * const ThemeDidChangeNotification;
#endif

#define kThemeName @"theme.bundle"

#define kThemeDefault   @"default"
#define kThemeBlack     @"black"

#define IMAGE(imagePath) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(imagePath) ofType:@"png"]]

#define ThemePlaceHolder ThemeImage(@"placeholder")
#define ThemeImage(imageName) [[JHKThemeManager sharedInstance] imageWithImageName:(imageName)]
#define ThemeColor(keyname) [[JHKThemeManager sharedInstance] colorWithName:(keyname)]
#define ThemeFontSize(fontname) [[JHKThemeManager sharedInstance] fontSizeWithName:(fontname)]
#define ThemeJsonString(filename) [[JHKThemeManager sharedInstance] jsonStringWithFileName:(filename)]
#define ThemeJson(filename) [[JHKThemeManager sharedInstance] jsonWithFileName:(filename)]
#define ThemeJs(filename) [[JHKThemeManager sharedInstance] jsWithFileName:(filename)]
#define ThemeSaveJson(filename,data) [[JHKThemeManager sharedInstance] jsonSaveFileName:(filename) content:(data)]
#define ThemeReadJson(filename) [[JHKThemeManager sharedInstance] jsonReadFileName:(filename)]
#define ThemeSaveJsonObject(filename,data) [[JHKThemeManager sharedInstance] jsonObjectSaveFileName:(filename) content:(data)]
#define ThemeReadJsonObject(filename) [[JHKThemeManager sharedInstance] jsonObjectReadFileName:(filename)]

#define ThemeReadJsonBundle(filename) [[JHKThemeManager sharedInstance] jsonFromBoundleReadFileName:(filename)]

typedef enum {
    ThemeStatusWillChange = 0, // todo
    ThemeStatusDidChange,
} ThemeStatus;


NS_ASSUME_NONNULL_BEGIN

@interface JHKThemeManager : NSObject

@property (strong, nonatomic) NSString *theme;

+ (JHKThemeManager *)sharedInstance;

- (UIImage *)imageWithImageName:(NSString *)imageName;
#pragma mark 获取颜色配置
- (UIColor*)colorWithName:(NSString*)keyname;
- (CGFloat)fontSizeWithName:(NSString*)fontname;

- (NSString *)jsonStringWithFileName:(NSString *)filename;
- (id)jsonWithFileName:(NSString *)filename;
- (void)jsonSaveFileName:(NSString *)name content:(NSString *)json;

- (void)jsonObjectSaveFileName:(NSString *)name content:(id)jsonObject;
- (id)jsonObjectReadFileName:(NSString *)name;

- (NSString *)jsonReadFileName:(NSString *)name;
- (NSString *)jsWithFileName:(NSString *)filename;
#pragma mark 读取文件
- (id)jsonFromBoundleReadFileName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
