//
//  NSMutableArray+JHKStack.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray<ObjectType> (JHKStack)

/**入栈*/
- (ObjectType)push:(NSObject *)value;
/**出栈*/
- (ObjectType)pop;

/**获取栈顶的数据*/
- (ObjectType)stackTop;
/**获取栈底的数据*/
- (ObjectType)stackBottom;
@end

NS_ASSUME_NONNULL_END
