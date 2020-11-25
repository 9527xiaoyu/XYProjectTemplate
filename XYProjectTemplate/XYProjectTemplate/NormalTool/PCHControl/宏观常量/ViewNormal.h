//
//  ViewNormal.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#ifndef ViewNormal_h
#define ViewNormal_h

#define kFontSize nF4_14

/*
 极细 纤细 细 常规 中粗 中黑
    PingFangSC-Ultralight,
    PingFangSC-Thin,
    PingFangSC-Light,
    PingFangSC-Regular,
    PingFangSC-Semibold,
    PingFangSC-Medium
*/

#define kFontUltralightName @"PingFangSC-Ultralight"
#define kFontThinName @"PingFangSC-Thin"
#define kFontLightName @"PingFangSC-Light"
#define kFontRegularName @"PingFangSC-Regular"
#define kFontMediumName @"PingFangSC-Medium"
#define kFontSemiboldName @"PingFangSC-Semibold"
#define kFontBoldName kFontSemiboldName

#define kFontHelvetica @"Helvetica"

#define kFontNormal(fontName,fontSize) [JHKFont fontWithName:fontName size:fontSize]

#define kFontThin(fontSize) [JHKFont fontWithName:kFontThinName size:fontSize]
#define kFont(fontSize) [JHKFont fontWithName:kFontRegularName size:fontSize]
#define kFontMediem(fontSize) [JHKFont fontWithName:kFontMediumName size:fontSize]
#define kFontBold(fontSize) [JHKFont fontWithName:kFontBoldName size:fontSize]

#define kFontASCIIName @"arial"
#define kFontASCIIBoldName @"DINAlternate-Bold"

#define kFontASCII(fontSize) [JHKFont fontWithName:kFontASCIIName size:fontSize]
#define kFontASCIIBold(fontSize) [JHKFont fontWithName:kFontASCIIBoldName size:fontSize]

#define kDefaultFont kFont(kFontSize)

//-----------------------字体颜色----------------------------
#pragma mark - 字体颜色
#define kBgcolor jhkRGB(238,238,238)
#define k1Titlecolor jhkRGB(74,74,74)
#define k2Titlecolor jhkRGB(104,104,104)
#define k3Titlecolor jhkRGB(134,134,134)
#define k4Titlecolor jhkRGB(166,166,166)
#define k5Titlecolor jhkRGB(234,79,77)
#define k6Titlecolor jhkRGB(51,204,102)
#define k7Titlecolor jhkRGB(0,153,255)
#define k8Titlecolor jhkRGB(108,124,161)
#define k9Titlecolor jhkRGB(193,193,193)
#define kd2linecolor jhkRGB(220,220,220)

//-----------------------字体大小----------------------------
#pragma mark - 字体大小
#define kATitleSize 11
#define kBTitleSize 12
#define kCTitleSize 14
#define kDTitleSize 15
#define kETitleSize 16
#define kFTitleSize 18
#define kGTitleSize 25
#define kHTitleSize 35
#define kITitleSize 40

//----------------------颜色类---------------------------
// 获取RGB颜色
#define jhkRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define jhkRGB(r,g,b) jhkRGBA(r,g,b,1.0f)

#pragma mark - UIColor宏定义
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)

// 色彩
#define jhkColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
//#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0]
#define jhkRandom255Color arc4random()%255
/**
 * 随机色
 */
#define jhkRandomColor jhkColor(jhkRandom255Color,jhkRandom255Color,jhkRandom255Color)

//-----------------------常用颜色----------------------------
#define jhkClearColor [UIColor clearColor]
#define jhkRedColor UIColorFromRGB(0xde3031)
#define jhkGreenColor UIColorFromRGB(0x18c062)
#define jhkGreyColor UIColorFromRGB(0xb0b0b0)
#define jhkBlueColor UIColorFromRGB(0x0592ff)
#define jhkYellowColor UIColorFromRGB(0xff8448)
#define jhkLowGreenColor UIColorFromRGB(0x61da9d)
#define jhkBlackColor UIColorFromRGB(0x000000)

#endif /* ViewNormal_h */
