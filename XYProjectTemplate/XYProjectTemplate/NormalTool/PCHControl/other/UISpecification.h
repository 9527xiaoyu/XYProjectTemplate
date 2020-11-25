//
//  UISpecification.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#ifndef UISpecification_h
#define UISpecification_h

#import "JHKThemeManager.h"
#import "JHKViewFormatFactory.h"

#define nC0_ClearColor [UIColor clearColor];
#define nC1_EE403C_red ThemeColor(@"Normal_C1_Red")
#define nC2_000000_black ThemeColor(@"Normal_C2_Black")

#define nC3_003569_blue ThemeColor(@"Normal_C3_Blue")
#define nC4_333333 ThemeColor(@"Normal_C4_SubTitle")
#define nC5_666666 ThemeColor(@"Normal_C5_NormalTitle")
#define nC6_999999 ThemeColor(@"Normal_C6_AidTitle")

#define nC7_DDDDDD ThemeColor(@"Normal_C7_SeparateLine")
#define nC8_EEEEEE ThemeColor(@"Normal_C8_SecondSeparateLine")
#define nC9_F8F8F8 ThemeColor(@"Normal_C9_Background")
#define nC10_FFFFFF_white ThemeColor(@"Normal_C10_ButtonTitle")

#define titleDefaultColor UIColorFromRGB(0x646464)

#define SHADOWOPACITY 0.2

#define DARK_CELL_COLOR UIColorFromRGB(0x2C2C2C)

/**
 *主题颜色_绿
 */
#define themeGreenColor themePurplesColor
//UIColorFromRGB(0x00AF6B)
#define themeLightGreenColor UIColorFromRGB(0xE0F5ED)

/**
 * 答题报告选择结果(为区分主题色)
 */
#define themeGreenForResult UIColorFromRGB(0x00AF6B)
/**
 *主题颜色_灰
 */
#define themeGreyColor UIColorFromRGB(0xf6f6f6)
/**
 *主题颜色_红
 */
#define themeRedColor UIColorFromRGB(0xF04F54)
/**
 *主题颜色_嫣红
 */
#define themePurplesColor UIColorFromRGB(0xEB4462)
#define themeLineColor UIColorFromRGB(0xE6E6E6)

/*原 WJBACK_COLOR */
#define themeBACK_COLOR UIColorFromRGB(0xededed)

//#define kNightTextColor UIColorFromRGB(0x818181)
//#define kDayTextColor nC2_000000_black

//#define kNightBackgroundColor [UIColor groupTableViewBackgroundColor]
//#define kDayBackgroundColor [UIColor groupTableViewBackgroundColor]

#define nC_VC_BACKGROUND UIColorFromRGB(0xf8f8f8)

#define nC_1F1F1F_black3 UIColorFromRGB(0x1f1f1f)

#define nF1_18 ThemeFontSize(@"Normal_Font_F1")
#define nF2_16 ThemeFontSize(@"Normal_Font_F2")
#define nF3_15 ThemeFontSize(@"Normal_Font_F3")
#define nF4_14 ThemeFontSize(@"Normal_Font_F4")
#define nF5_12 ThemeFontSize(@"Normal_Font_F5")
#define nF6_10 ThemeFontSize(@"Normal_Font_F6")

#endif /* UISpecification_h */
