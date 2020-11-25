//
//  FunctionNormal.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#ifndef FunctionNormal_h
#define FunctionNormal_h

#import "AppDelegate.h"

#define userDefault [NSUserDefaults standardUserDefaults]
#define jhkAppDelegate [AppDelegate delegate]

#define executeBlock(name) !name?:name()
#define executeBlockWithParameter(name,...) !name?:name(__VA_ARGS__)

#define jhkRandomBoolean (arc4random()%2)

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

typedef void (^ RespondControl)(id sender);

#define nsstrfloat(floatNum) [NSString stringWithFormat:@"%g",floatNum]
#define nsstrinteger(integerNum) [NSString stringWithFormat:@"%ld",(long)integerNum]
#define nsstruinteger(uintegerNum) [NSString stringWithFormat:@"%lu",(long)uintegerNum]
#define nsstrint(intNum) [NSString stringWithFormat:@"%d",intNum]
#define nsstruint(uintNum) [NSString stringWithFormat:@"%u",uintNum]

#define nsstrcat(str1,str2) [str1 stringByAppendingString:str2]
#define nsstrformatcat(...) [NSString stringWithFormat:__VA_ARGS__]

// 自定义Log
#ifdef DEBUG
    #define jhkLog(FORMAT, ...) fprintf(stderr,"# [%s:%d]\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
    #define STDLog(FORMAT, ...) fprintf(stderr,"# %s\n",[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//    #define jhkLog(...) NSLog(@"%s %d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
    #define jhkLog(...)
    #define STDLog(...)
#endif

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define SuppressUndeclaredSelectorWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/*
#define SuppressOCWarning(WarningName,Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored "#WarningName) \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
 */

#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#endif /* FunctionNormal_h */
