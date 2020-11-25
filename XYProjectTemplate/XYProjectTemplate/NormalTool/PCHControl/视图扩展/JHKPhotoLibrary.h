//
//  JHKPhotoLibrary.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PHAssetCollection;
@class PHAsset;

typedef void(^WriteImageCompletionBlock)(PHAsset *imageAsset);

typedef void(^WriteVideoCompletionBlock)(NSURL *videoUrl);

typedef void(^AccessFailureBlock)(NSError *error);

@interface JHKPhotoLibrary : NSObject
/**
 * 创建相册
 *
 * @param albumName 相册名
 */
- (PHAssetCollection *)createNewAlbumCalled:(NSString *)albumName;

/**
 * 保存普通的图片到相册
 *
 * @param image 图片
 * @param albumName 相册名
 * @param completion 成功回调
 * @param failure 失败回调
 */
- (void)saveImage:(UIImage *)image toAlbum:(NSString *)albumName completion:(WriteImageCompletionBlock)completion failure:(AccessFailureBlock)failure;

/**
 * 保存URL链接的图片到相册
 *
 * @param imageUrl 图片链接
 * @param albumName 相册名
 * @param completion 成功回调
 * @param failure 失败回调
 */
- (void)saveImageWithImageUrl:(NSURL *)imageUrl toAlbum:(NSString *)albumName completion:(WriteImageCompletionBlock)completion failure:(AccessFailureBlock)failure;

/**
 * 保存视频到相册
 *
 * @param videoUrl 视频
 * @param albumName 相册名
 * @param completion 成功回调
 * @param failure 失败回调
 */
- (void)saveVideoWithUrl:(NSURL *)videoUrl toAlbum:(NSString *)albumName completion:(WriteVideoCompletionBlock)completion failure:(AccessFailureBlock)failure;

/**
 * 保存图片数据到相册
 *
 * @param imageData 图片数据
 * @param albumName 相册名
 * @param completion 成功回调
 * @param failure 失败回调
 */
- (void)saveImageWithData:(NSData *)imageData toAlbum:(NSString *)albumName completion:(WriteImageCompletionBlock)completion failure:(AccessFailureBlock)failure;

/**
 * 获取本地创建的相册里所有图片
 *
 * @param albumName 相册名
 * @param completion 成功回调
 */
- (void)loadImagesFromAlbum:(NSString *)albumName completion:(void (^)(NSMutableArray *images, NSError *error))completion;
@end

NS_ASSUME_NONNULL_END
