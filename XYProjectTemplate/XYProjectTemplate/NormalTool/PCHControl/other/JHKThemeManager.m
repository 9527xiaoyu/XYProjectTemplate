//
//  JHKThemeManager.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKThemeManager.h"

NSString * const ThemeDidChangeNotification = @"me.ilvu.theme.change";

@implementation JHKThemeManager

@synthesize theme = _theme;

+ (JHKThemeManager *)sharedInstance
{
    static dispatch_once_t once;
    static JHKThemeManager *instance = nil;
    dispatch_once( &once, ^{ instance = [[JHKThemeManager alloc] init]; } );
    return instance;
}

- (void)setTheme:(NSString *)theme
{
    if (_theme) {
        _theme = nil;
    }
    _theme = [theme copy];
    
    // post notification to notify the observers that the theme has changed
    ThemeStatus status = ThemeStatusDidChange;
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:ThemeDidChangeNotification
     object:[NSNumber numberWithInt:status]];
    
    [[NSUserDefaults standardUserDefaults] setObject:theme forKey:@"setting.theme"];
    
}

- (UIImage *)imageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        return image;
    }
    
    NSString *directory = [NSString stringWithFormat:@"%@/%@", kThemeName,[self theme]];
    if ([imageName rangeOfString:@"/"].location>0 && [imageName rangeOfString:@"/"].location<NSIntegerMax) {
        NSArray *dirs = [imageName componentsSeparatedByString:@"/"];
        NSString *ndir = [imageName stringByReplacingOccurrencesOfString:[dirs lastObject] withString:@""];
        directory = [directory stringByAppendingString:[NSString stringWithFormat:@"/%@",ndir]];
        imageName = [dirs lastObject];
    }
    NSString *originImageName = imageName;
    NSString *imageName_568 = [imageName stringByAppendingString:@"-568@2x"];
    NSString *imageName_3x = [imageName stringByAppendingString:@"@3x"];
    imageName = [imageName stringByAppendingString:@"@2x"];
    
    
    NSString *imagePath_origin = [[NSBundle mainBundle] pathForResource:originImageName
                                                          ofType:@"png"
                                                     inDirectory:directory];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName
                                                          ofType:@"png"
                                                     inDirectory:directory];
    NSString *imagePath_568 = [[NSBundle mainBundle] pathForResource:imageName_568
                                                              ofType:@"png"
                                                         inDirectory:directory];
    NSString *imagePath_3x = [[NSBundle mainBundle] pathForResource:imageName_3x
                                                              ofType:@"png"
                                                         inDirectory:directory];
    NSFileManager *f = [[NSFileManager defaultManager] init];
    if (!iPhone4 && [f fileExistsAtPath:imagePath_568]) {
        imagePath = imagePath_568;
    }else if ((iPhone6Plus) && [f fileExistsAtPath:imagePath_3x]) {
        imagePath = imagePath_3x;
    }else if(![f fileExistsAtPath:imagePath]){
        imagePath = imagePath_origin;
    }
    f = nil;
    
    UIImage *img = [UIImage imageWithContentsOfFile:imagePath];
    
    return img;
}

- (NSString *)jsonStringWithFileName:(NSString *)filename
{
    NSString *directory = [NSString stringWithFormat:@"%@/json", kThemeName];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:filename ofType:@".json" inDirectory:directory];
    NSString *jsonstr = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    return jsonstr;
}

- (id)jsonWithFileName:(NSString *)filename
{
    NSString *jsonstr = [self jsonStringWithFileName:filename];
    jsonstr = [self parseJsonFile:jsonstr];
    
    id jsonObject = [self json2Object:jsonstr];
    if (!jsonObject) {
        NSString *msg = [NSString stringWithFormat:@"%@路径不存在或内容格式不对!",filename];
        NSAssert(false,msg);
    }
    
    return jsonObject;
}

- (NSString *)parseJsonFile:(NSString *)jsonstr
{
    id jsonObject = [self json2Object:jsonstr];
    if ([jsonObject isKindOfClass:[NSDictionary class]] || [jsonObject isKindOfClass:[NSArray class]]) {
        return jsonstr; //没加密的直接返回
    }
    
    NSMutableString *decode = [@"" mutableCopy];
    NSString *str = jsonstr;
    for (int i = 0; i < str.length; i++) {
        int ch = [str characterAtIndex:i];
        int decode_ch = (ch - 1) ^ 110;
        [decode appendString:[NSString stringWithFormat:@"%c",decode_ch]];
    }
    
    NSString *originJson = __jhkTEXT(decode);
    return originJson;
}

- (id)json2Object:(NSString *)jsonstr
{
    NSData *jsonData = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *json;
    
    NSError *error;
    if (jsonData) {
        json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    }
    
    return json;
}

- (NSString *)jsWithFileName:(NSString *)filename
{
    NSString *directory = [NSString stringWithFormat:@"%@/js", kThemeName];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:filename
                                                         ofType:@".js"
                                                    inDirectory:directory];
    
    NSString *jsonstr = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    return jsonstr;
}

- (void)jsonSaveFileName:(NSString *)name content:(NSString *)json
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths[0] stringByAppendingPathComponent:@"config"];
    
    NSString *jsonPath = [path stringByAppendingString:nsstrcat(name, @".json")];
    [json writeToFile:jsonPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    jhkLog(@"%@",jsonPath);
}

- (NSString *)jsonReadFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths[0] stringByAppendingPathComponent:@"config"];
    
    NSString *jsonPath = [path stringByAppendingString:nsstrcat(name, @".json")];
    NSString *content = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    
    return content;
}

- (void)jsonObjectSaveFileName:(NSString *)name content:(id)jsonObject
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths[0] stringByAppendingPathComponent:@"config"];
    
    NSString *jsonPath = [path stringByAppendingString:nsstrcat(name, @".json")];
    
    [jsonObject writeToFile:jsonPath atomically:YES];
}

- (id)jsonObjectReadFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths[0] stringByAppendingPathComponent:@"config"];
    
    NSString *jsonPath = [path stringByAppendingString:nsstrcat(name, @".json")];
    id content = [NSDictionary dictionaryWithContentsOfFile:jsonPath];
    if (!content) {
        content = [NSArray arrayWithContentsOfFile:jsonPath];
    }
    
    return content;
}

#pragma mark 获取颜色配置
-(UIColor*)colorWithName:(NSString*)keyname{
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    //NSLog(@"bundlepath:%@",bundlePath);
    
    NSString *filename = [bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/Color.plist",kThemeName,[self theme]]];
    //读文件
    NSDictionary* plist = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSString *value = [plist objectForKey:keyname];
    plist = nil;
    filename = nil;
    bundlePath = nil;
    if (value) {
        
        UIColor *c = [fn colorWithHexString:value];
        value = nil;
        return c;
    }
    return UIColorFromRGB(0xFFFFFF);
}

-(CGFloat)fontSizeWithName:(NSString*)fontname
{
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *filename = [bundlePath stringByAppendingString:[NSString stringWithFormat:@"/%@/%@/Font.plist",kThemeName,[self theme]]];
    NSDictionary* plist = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSString *value = [plist objectForKey:fontname];
    
    CGFloat fontSize = [self convertPx2Pt:[value floatValue]];
    
    return fontSize;
}

- (CGFloat)convertPx2Pt:(CGFloat)px
{
    // 按照iPhone6为原型图情况字体大小作为标准
//    CGFloat pt = px / 96 * 72;
    CGFloat pt = px / 2;
    return pt;
}

- (NSString *)theme
{
    if ( _theme == nil )
    {
        NSString *_t = [[NSUserDefaults standardUserDefaults] objectForKey:@"setting.theme"];
        if (!_t) {
            _t = @"default";
        }
        return _t;
    }
    return _theme;
}

#pragma mark - 读取bundle
- (id)jsonFromBoundleReadFileName:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];

    id plist = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return plist;
}


@end
