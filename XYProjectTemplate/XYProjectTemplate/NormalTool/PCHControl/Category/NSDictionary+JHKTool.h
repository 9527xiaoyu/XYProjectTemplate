//
//  NSDictionary+JHKTool.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JHKTool)

/** 判断两个字典中所有值相同,并且key所对应的NSString类型的value也相同*/
- (BOOL)judgeDictEqaulValue:(NSDictionary *)dict;
/**转成JSON字符串*/
- (NSString* )convertToJSONString;
@end

NS_ASSUME_NONNULL_END
