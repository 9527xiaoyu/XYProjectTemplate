//
//  UIImage+JHKUtil.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "UIImage+JHKUtil.h"


@implementation UIImage (JHKUtil)

+ (NSData *)compressImage:(UIImage *)image
{
    CGSize size = [self scaleSize:image.size];
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //自行规定尺寸
    NSUInteger maxFileSize = 500 * 1024;
    CGFloat compressionRatio = 0.7f;
    CGFloat maxCompressionRatio = 0.1f;
    
    NSData *imageData = UIImageJPEGRepresentation(scaledImage, compressionRatio);
    
    while (imageData.length > maxFileSize && compressionRatio > maxCompressionRatio) {
        compressionRatio -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compressionRatio);
    }
    
    return imageData;
}

+ (CGSize)scaleSize:(CGSize)sourceSize
{
    float width = sourceSize.width;
    float height = sourceSize.height;
    if (width >= height) {//自行规定尺寸
        return CGSizeMake(800, 800 * height / width);
    } else {
        return CGSizeMake(800 * width / height, 800);
    }
}

+ (UIImage *)imageWithMaxSide:(CGFloat)length sourceImage:(UIImage *)image
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    CGSize imgSize = CWSizeReduce(image.size, length);
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
    
    [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
            blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
    
    img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
    UIGraphicsEndImageContext();
    
    return img;
}

static inline
CGSize CWSizeReduce(CGSize size, CGFloat limit)   // 按比例减少尺寸
{
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, limit*ratio);
    } else {
        imgSize = CGSizeMake(limit/ratio, limit);
    }
    
    return imgSize;
}

- (UIImage*)scaleImageToSize:(CGSize)size
{
    UIImage *image = self;
    UIGraphicsBeginImageContextWithOptions(size, 0, kScreenScale);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor
{
    NSParameterAssert(maskColor != nil);
    
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(context, 1.0f, -1.0f);
        CGContextTranslateCTM(context, 0.0f, -(imageRect.size.height));
        
        CGContextClipToMask(context, imageRect, self.CGImage);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextFillRect(context, imageRect);
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 color转image
 
 @param color color
 @return image
 */
+(UIImage*)imageWithColor:(UIColor*) color
{
    UIImage *image = [UIImage imageWithColor:color withSize:CGSizeMake(1.0, 1.0)];
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (CAGradientLayer *)produceGradientLayer
{
    CAGradientLayer*  gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[UIColor colorWithWhite:0.9f alpha:0.7f].CGColor,
                             (id)[UIColor colorWithWhite:0.0f alpha:0.3f].CGColor,
                             nil];
    gradientLayer.locations = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0f],
                                [NSNumber numberWithFloat:0.5f],
                                nil];
    //If you want to have a border for this layer also
    gradientLayer.borderColor = [UIColor colorWithWhite:1.0f alpha:1.0f].CGColor;
    gradientLayer.borderWidth = 1;
    
    return gradientLayer;
}

+ (UIImage *)createQRCodeFromString:(NSString *)string
{
    UIImage *image = [self createQRCodeFromString:string logoImage:@"" isShowLogo:NO];
    return image;
}

+ (UIImage *)createQRCodeFromString:(NSString *)string logoImage:(NSString*)logoImageName isShowLogo:(BOOL)showLogo
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    CIFilter *QRFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [QRFilter setValue:stringData forKey:@"inputMessage"];
    //容错率 L-->7%  M-->15%-->默认值  Q-->25%  H-->30%
    [QRFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    CGFloat scale = 5;
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:QRFilter.outputImage fromRect:QRFilter.outputImage.extent];
    
    //Scale the image usign CoreGraphics
    CGFloat width = QRFilter.outputImage.extent.size.width * scale;
    //开启图形绘制
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    //绘制二维码
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    if (showLogo) {
        UIImage *logoImage = ThemeImage(logoImageName);
        CGRect rect = CGRectMake((QRFilter.outputImage.extent.size.width-20.0)/2, (QRFilter.outputImage.extent.size.height-20.0)/2, 20, 20);
        CGContextDrawImage(context, rect, logoImage.CGImage);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //Cleaning up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    return image;
}

// 生成全屏3X图
+ (UIImage *)scale3xImage:(UIImage *)img size:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context        UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    UIGraphicsBeginImageContext(CGSizeMake(kScreenWidth*3.0, size.height*3.0*kScreenWidth/size.width));
    [img drawInRect:CGRectMake(0,0, kScreenWidth*3.0, size.height*3.0*kScreenWidth/size.width)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage*)grayscaleWithType:(int)type {
    
    CGImageRef imageRef = self.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            UInt8 brightness;
            switch (type) {
                case 1:
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                case 2:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                case 3:
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
        }
    }
    
    
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    return effectedImage;
}

- (UIImage *)cutImage:(CGRect)rect
{
    CGImageRef imageRef = self.CGImage;
    CGImageRef img = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage * newImage = [[UIImage alloc] initWithCGImage:img];
    return newImage;
}

- (void)drawPatternInRect:(CGRect)rect
{
    BOOL isHorizontal = false;
    if (self.size.width > self.size.height ) {
        isHorizontal = YES;
    }
    [self drawPatternInRect:rect isHorizontal:isHorizontal];
}

- (void)drawPatternInRect:(CGRect)rect isHorizontal:(BOOL)isHorizontal
{
    UIImage *image = self;
    
    CGSize drawSize = rect.size;
    
    CGFloat imgScale = image.size.height / image.size.width;
    
    CGFloat patternWidth,patternHeight,patternNum;
    CGRect patternImgRect;
    
    CGFloat gap = 0.3;
    
    if (isHorizontal) {
        patternHeight = drawSize.height;
        patternWidth = patternHeight / imgScale;
        patternNum = (int)(drawSize.width / patternWidth + 0.5);
        if (patternNum==0) {
            patternNum = 1;
        }
        patternWidth = drawSize.width / patternNum;
        
        for (int i = 0; i < patternNum; i++) {
            patternImgRect = CGRectMake(rect.origin.x + i*patternWidth - gap, rect.origin.y, 2*gap + patternWidth, patternHeight);
            [image drawInRect:patternImgRect];
        }
    }else{
        patternWidth = drawSize.width;
        patternHeight = patternWidth * imgScale;
        patternNum = (int)(drawSize.height / patternHeight + 0.5);
        if (patternNum==0) {
            patternNum = 1;
        }
        patternHeight = drawSize.height / patternNum;
        
        for (int i = 0; i < patternNum; i++) {
            patternImgRect = CGRectMake(rect.origin.x, rect.origin.y + i*patternHeight - gap, patternWidth, 2*gap + patternHeight);
            [image drawInRect:patternImgRect];
        }
    }

}

- (void)drawInRectFit:(CGRect)rect
{
    UIImage *image = self;
    
    CGFloat imgScale = image.size.width / image.size.height;
    CGFloat canvasScale = rect.size.width / rect.size.height;
    
    CGFloat x,y,width,height;
    if (imgScale >= canvasScale) {
        width = rect.size.width;
        height = width / imgScale;
        x = rect.origin.x;
        y = rect.origin.y + (rect.size.height - height)/2;
    }else{
        height = rect.size.height;
        width = height * imgScale;
        y = rect.origin.y;
        x = rect.origin.x + (rect.size.width - width)/2;
    }
    
    [image drawInRect:CGRectMake(x, y, width, height)];
}

- (BOOL)isValidPNGByImage
{
    NSData* tempData = UIImagePNGRepresentation(self);
    if (tempData == nil) {
        return NO;
    } else {
        return YES;
    }
}

///取gif图片第一帧
+ (CGFloat)loadGifImage:(NSString*)urlStr realWidth:(CGFloat)width
{
    NSURL *fileUrl = [NSURL URLWithString:urlStr];
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    if (!gifSource) {
        return 300.0/375*kScreenWidth;
    }
    size_t gifCount = CGImageSourceGetCount(gifSource);
    UIImage *image = nil;
    for (size_t i = 0; i< gifCount; i++) {
        if (i >= 1) {
            break;
        }
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, 0, NULL);
        image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    CGFloat height = image.size.height/image.size.width*width;
    return height;
}

+ (UIImage *)grayImage:(UIImage *)sourceImage
{
    int bitmapInfo = kCGImageAlphaNone;
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,width,height,8,0,colorSpace,bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context ==NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0,0, width, height), sourceImage.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

+ (UIImage*)cutCornerImage:(CGSize)size
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    view.backgroundColor = nC10_FFFFFF_white;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8,8)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, kScreenScale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    view = nil;
    return image;
}

@end
