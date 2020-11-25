//
//  NSMutableString+JHKUtil.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (JHKUtil)

/**插入非空数据*/
- (NSString *)appendNotNullString:(NSString *)string;
/**插入非空数据，以及间隔符号*/
- (NSString *)appendNotNullString:(NSString *)string withSeparate:(NSString *)separate;

@end

NS_ASSUME_NONNULL_END
