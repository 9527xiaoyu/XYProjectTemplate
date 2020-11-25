//
//  NSMutableArray+JHKStack.m
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import "NSMutableArray+JHKStack.h"

@implementation NSMutableArray (JHKStack)

- (__kindof NSObject *)push:(__kindof NSObject *)value
{
    if (value) {
        [self addObject:value];
    }
    return value;
}

- (__kindof NSObject *)pop
{
    if (!self.count) {
        return nil;
    }
    NSObject *value = [self lastObject];
    [self removeLastObject];
    return value;
}

- (__kindof NSObject *)stackTop
{
    if (!self.count) {
        return nil;
    }
    NSObject *value = [self lastObject];
    return value;
}

- (__kindof NSObject *)stackBottom
{
    if (!self.count) {
        return nil;
    }
    NSObject *value = [self firstObject];
    return value;
}

@end
