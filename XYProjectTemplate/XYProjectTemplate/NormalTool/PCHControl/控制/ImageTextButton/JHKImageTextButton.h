//
//  JHKImageTextButton.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "JHKPointInsideButton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ButtonLayoutAlign){
    ButtonLayoutAlignFreedom,
    ButtonLayoutAlignHorizonal,
    ButtonLayoutAlignVertical
};

@interface JHKImageTextButton : UIButton

@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;

@property (nonatomic,assign) UIOffset offset;

@property (nonatomic) ButtonSizeType sizeType;
@property (nonatomic) ButtonLayoutAlign layoutStyle;
@end

NS_ASSUME_NONNULL_END
