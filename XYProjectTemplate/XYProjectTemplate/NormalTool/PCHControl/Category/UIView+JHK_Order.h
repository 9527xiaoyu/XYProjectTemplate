//
//  UIView+JHK_Order.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JHK_Order)
-(NSUInteger)getSubviewIndex;
-(void)bringToFront;
-(void)sendToBack;
-(void)bringOneLevelUp;
-(void)sendOneLevelDown;
-(BOOL)isInFront;
-(BOOL)isAtBack;
-(void)swapDepthsWithView:(UIView*)swapView;
@end

NS_ASSUME_NONNULL_END
