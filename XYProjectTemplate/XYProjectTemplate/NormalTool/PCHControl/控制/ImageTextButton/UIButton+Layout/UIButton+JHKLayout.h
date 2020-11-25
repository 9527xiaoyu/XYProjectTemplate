//
//  UIButton+JHKLayout.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,UIButtonLayoutAlign){
    UIButtonLayoutAlignFreedom,
    UIButtonLayoutAlignHorizonal,
    UIButtonLayoutAlignVertical
};

@interface UIButton (JHKLayout)

@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;

@property (nonatomic) UIButtonLayoutAlign layoutStyle;

@end

NS_ASSUME_NONNULL_END
