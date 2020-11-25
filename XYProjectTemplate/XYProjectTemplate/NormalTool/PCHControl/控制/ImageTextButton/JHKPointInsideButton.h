//
//  JHKPointInsideButton.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ButtonSizeType){
    ButtonSizeTypeSmall,
    ButtonSizeTypeCenter,
    ButtonSizeTypeBig
};

@interface JHKPointInsideButton : UIButton
@property (nonatomic) ButtonSizeType sizeType;
@end

NS_ASSUME_NONNULL_END
