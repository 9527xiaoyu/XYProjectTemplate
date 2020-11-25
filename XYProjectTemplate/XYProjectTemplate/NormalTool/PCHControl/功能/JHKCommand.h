//
//  JHKCommand.h
//  JinHuKao
//
//  Created by 杨晓宇 on 2020/10/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kCommandPrefix @"jhk://"

@interface JHKCommand : NSObject
@property (nonatomic,strong,readonly) NSString *command;
@property (nonatomic,strong,readonly) NSString *body;
@property (nonatomic,strong,readonly) NSString *urlArg;
@property (nonatomic,strong,readonly) NSDictionary *params;

+ (BOOL)couldParse:(NSString *)commandString;
- (void)execute;

- (instancetype)initWithCommand:(NSString *)command;
- (BOOL)havaParam:(NSString *)param;
- (id)valueWithParam:(NSString *)param;

- (void)showListView:(NSArray *)dataSource;
@end

NS_ASSUME_NONNULL_END
