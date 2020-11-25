//
//  JHKTerminal.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>
#import "TerminalConfig.h"

NS_ASSUME_NONNULL_BEGIN

#define cmd__ [JHKTerminal sharedTerminal]

@interface JHKTerminal : NSObject
+ (instancetype)sharedTerminal;

- (BOOL)couldParse:(NSString *)command;
- (void)parse:(NSString *)command;
@end

NS_ASSUME_NONNULL_END
