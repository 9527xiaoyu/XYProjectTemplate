//
//  UIView+JHKUnderLine.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, UnderLineType) {
    UnderLineTypeNone = 0,
    UnderLineTypeUp = 1 << 1,
    UnderLineTypeLeft = 1 << 2,
    UnderLineTypeDown  = 1 << 3,
    UnderLineTypeRight    = 1 << 4,
    UnderLineTypeUpAndDown = UnderLineTypeUp | UnderLineTypeDown,
    UnderLineTypeLeftAndRight = UnderLineTypeLeft | UnderLineTypeRight,
    UnderLineTypeAll = UnderLineTypeUp | UnderLineTypeDown | UnderLineTypeLeft | UnderLineTypeRight
};

@interface UIView (JHKUnderLine)

@property (nonatomic) UnderLineType underLineType;
@property (nonatomic,strong) UIColor *underLineColor;

-(void)drawUnderLine:(CGContextRef)ctx rect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
