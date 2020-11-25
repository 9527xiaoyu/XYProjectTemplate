//
//  UIImage+JHKUtil.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

CG_INLINE
CGSize CGSizeScale(CGSize size,CGFloat scale)
{
    return CGSizeMake(size.width * scale, size.height * scale);
}

CG_INLINE
CGRect CGRectScale(CGRect rect,CGFloat scale)
{
    return CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
}

@interface UIImage (JHKUtil)
/**压缩图片---转数据*/
+ (NSData *)compressImage:(UIImage *)image;
/**规定最大边长度*/
+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image;
- (UIImage*)scaleImageToSize:(CGSize)size;

+ (CAGradientLayer *)produceGradientLayer;
/**图片背景色*/
- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;

/**
 color转image
 
 @param color color
 @return image
 */
+(UIImage*)imageWithColor:(UIColor*) color;

/**
 *通过颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

/**
 *生成二维码
 */
+ (UIImage *)createQRCodeFromString:(NSString *)string;
+ (UIImage *)createQRCodeFromString:(NSString *)string logoImage:(NSString*)logoImageName isShowLogo:(BOOL)showLogo;

// 生成全屏3X图
+ (UIImage *)scale3xImage:(UIImage *)img size:(CGSize)size;
- (UIImage*)grayscaleWithType:(int)type;

// 切割精灵图
- (UIImage *)cutImage:(CGRect)rect;
// 平铺图片
- (void)drawPatternInRect:(CGRect)rect;
- (void)drawPatternInRect:(CGRect)rect isHorizontal:(BOOL)isHorizontal;
- (void)drawInRectFit:(CGRect)rect;

- (BOOL)isValidPNGByImage;

///取gif图片第一帧
+ (CGFloat)loadGifImage:(NSString*)urlStr realWidth:(CGFloat)width;
+ (UIImage *)grayImage:(UIImage *)sourceImage;

//切一张指定左右的圆角图
+ (UIImage*)cutCornerImage:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
