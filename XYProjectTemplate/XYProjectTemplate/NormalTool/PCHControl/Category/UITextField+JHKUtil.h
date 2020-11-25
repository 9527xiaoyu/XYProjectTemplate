//
//  UITextField+JHKUtil.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    kIDCardNoTYPe,//没有类型限制
    kIDCardNoTextFieldType, //身份证号
    kPhoneNumberTextFieldType, //手机号
    kBankCardNumberTextFieldType, //银行卡号
    kBankYanZhengMaTextFieldType //验证码
    
}kTextFieldType;

@interface UITextField (JHKUtil)
- (void)setTextOffset:(UIOffset)offset;
/**
 *  输入号码格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 *  参数 type 文本框输入号码类型（身份证，手机号，银行卡）
 */


+ (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textFieldType:(kTextFieldType)type;
@end

NS_ASSUME_NONNULL_END
