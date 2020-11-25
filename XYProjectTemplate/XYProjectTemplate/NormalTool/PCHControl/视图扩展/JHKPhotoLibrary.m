//
//  JHKPhotoLibrary.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/11/10.
//

#import "JHKPhotoLibrary.h"
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger,SaveImageType) {
    SaveImageTypeNormal = 1,
    SaveImageTypeUrl,
    SaveImageTypeData,
    SaveImageTypeVideo
};

@implementation JHKPhotoLibrary

- (PHAssetCollection *)createNewAlbumCalled:(NSString *)albumName
{
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:albumName]) {
            //相册已存在
            return collection;
        }
    }
    //不存在创建
    __block NSString *collectionId = nil;
    NSError *error;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (!error) {
        //相册创建成功
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
    }else{
        //相册创建失败
        return nil;
    }
}

- (void)saveImage:(UIImage *)image toAlbum:(NSString *)albumName completion:(WriteImageCompletionBlock)completion failure:(AccessFailureBlock)failure
{
    //保存图片到指定的相册(albumName)
    [self saveObject:image withType:SaveImageTypeNormal toAlbum:albumName completion:^(id callbackObject) {
        completion((PHAsset *)callbackObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)saveImageWithImageUrl:(NSURL *)imageUrl toAlbum:(NSString *)albumName completion:(WriteImageCompletionBlock)completion failure:(AccessFailureBlock)failure
{
    [self saveObject:imageUrl withType:SaveImageTypeUrl toAlbum:albumName completion:^(id callbackObject) {
        completion((PHAsset *)callbackObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)saveVideoWithUrl:(NSURL *)videoUrl toAlbum:(NSString *)albumName completion:(WriteVideoCompletionBlock)completion failure:(AccessFailureBlock)failure
{
    [self saveObject:videoUrl withType:SaveImageTypeVideo toAlbum:albumName completion:^(id callbackObject) {
        completion((NSURL *)callbackObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)saveImageWithData:(NSData *)imageData toAlbum:(NSString *)albumName completion:(WriteImageCompletionBlock)completion failure:(AccessFailureBlock)failure
{
    [self saveObject:imageData withType:SaveImageTypeData toAlbum:albumName completion:^(id callbackObject) {
        completion((PHAsset *)callbackObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}



- (void)saveObject:(id)object withType:(SaveImageType)savetype toAlbum:(NSString *)albumName completion:(void(^)(id callbackObject))completion failure:(void(^)(NSError *error))failure
{
    [self canAccessPhotoAlbum:^(BOOL result) {
        if (!result) {
            // 提示用户开启允许访问相册的权限
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
                [JHKAlertTool normalLeeAlertWithTitle:@"照片权限受限" content:@"请在iPhone的\"设置->隐私->照片\"选项中,允许\"金护考\"访问您的相册." cancelBtn:@"好" sureBtn:@"去设置" sureHandler:^{
                    if ([JHKSystemUtil canOpenSystemSettingView]) {
                        [JHKSystemUtil systemSettingView];
                    }
                }];
            } else {
                [JHKAlertTool normalLeeAlertWithTitle:@"照片权限受限" content:@"请在iPhone的\"设置->隐私->照片\"选项中,允许\"金护考\"访问您的相册." cancelBtn:@"好的"];
            }
        }else{
            __block NSString *assetId = nil;
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                assetId = [self getLocalIdentifierBy:object withType:savetype];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
                if (error) {
                    return;
                }
                PHAssetCollection *collection = [self createNewAlbumCalled:albumName];
                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                    PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
                    [request addAssets:@[asset]];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    NSLog(@"Finished updating asset. %@", (success ? @"Success." : error));
                    if (success) {
                        if (savetype == SaveImageTypeNormal || savetype == SaveImageTypeUrl || savetype == SaveImageTypeData) {
                            completion([PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject);
                        }else{
                            [[PHImageManager defaultManager] requestAVAssetForVideo:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                                completion([(AVURLAsset *)asset URL]);
                            }];
                        }
                        return;
                    }else{
                        failure(error);
                    }
                }];
            }];
        }
    }];
}


- (NSString *)getLocalIdentifierBy:(id)object withType:(SaveImageType)saveType
{
    if (saveType == SaveImageTypeNormal) {//普通的图片
        return [PHAssetCreationRequest creationRequestForAssetFromImage:(UIImage *)object].placeholderForCreatedAsset.localIdentifier;
    }else if (saveType == SaveImageTypeUrl){//URL链接
        return [PHAssetCreationRequest creationRequestForAssetFromImageAtFileURL:(NSURL *)object].placeholderForCreatedAsset.localIdentifier;
    }else if (saveType == SaveImageTypeData){//数据类型
        PHAssetCreationRequest *creationRequest = [PHAssetCreationRequest creationRequestForAsset];
        [creationRequest addResourceWithType:PHAssetResourceTypePhoto data:(NSData *)object options:nil];
        return creationRequest.placeholderForCreatedAsset.localIdentifier;
    }else{//视频类型
        return [PHAssetCreationRequest creationRequestForAssetFromVideoAtFileURL:(NSURL *)object].placeholderForCreatedAsset.localIdentifier;
    }
}

- (id)getCallBackObjectBy:(NSString *)assetId withType:(SaveImageType)saveType
{
    if (saveType == SaveImageTypeNormal || saveType == SaveImageTypeUrl || saveType == SaveImageTypeData) {
        return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
    }else{
        __block NSURL *url = nil;
        [[PHImageManager defaultManager] requestAVAssetForVideo:[PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            url = [(AVURLAsset *)asset URL];
        }];
        return url;
    }
}

- (void)loadImagesFromAlbum:(NSString *)albumName completion:(void (^)(NSMutableArray *images, NSError *error))completion
{
    [self canAccessPhotoAlbum:^(BOOL result) {
        if (!result) {
            // 提示用户开启允许访问相册的权限
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
                [JHKAlertTool normalLeeAlertWithTitle:@"照片权限受限" content:@"请在iPhone的\"设置->隐私->照片\"选项中,允许\"金护考\"访问您的相册." cancelBtn:@"好" sureBtn:@"去设置" sureHandler:^{
                    if ([JHKSystemUtil canOpenSystemSettingView]) {
                        [JHKSystemUtil systemSettingView];
                    }
                }];
            } else {
                [JHKAlertTool normalLeeAlertWithTitle:@"照片权限受限" content:@"请在iPhone的\"设置->隐私->照片\"选项中,允许\"金护考\"访问您的相册." cancelBtn:@"好的"];
            }
        }else{
            PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
            PHFetchOptions *fetchOptions = [PHFetchOptions new];
            fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
            fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
            [collectionResult enumerateObjectsUsingBlock:^(PHAssetCollection * collection, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([collection.localizedTitle isEqualToString:albumName]) {
                    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
                    __block NSMutableArray *imagesArr = [[NSMutableArray alloc] init];
                    [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        PHAsset *asset = (PHAsset *)obj;
                        PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
                        option.networkAccessAllowed = YES;
                        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
                            if (downloadFinined && result) {
                                [imagesArr addObject:result];
                                if (imagesArr.count == fetchResult.count) {
                                    completion(imagesArr,nil);
                                }
                            }
                        }];
                    }];
                    *stop = YES;
                    return;
                }
            }];
        }
    }];
}


//  判断授权状态
- (void)canAccessPhotoAlbum:(void (^)(BOOL result))result
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        // User has not yet made a choice with regards to this application
        //@"用户还没有关于这个应用程序做出了选择"
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                result(YES);
            }
        }];
    }else if (status == PHAuthorizationStatusAuthorized){
        //@"用户同意使用"
        result(YES);
    }else{
        //@"用户禁止使用"
        result(NO);
    }
}
@end
