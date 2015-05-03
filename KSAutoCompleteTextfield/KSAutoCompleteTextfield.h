//
//  KSAutoCompleteTextfield.h
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

// KSAutoCompleteTextfieldStatus_input    表示是正常输入的状态
// KSAutoCompleteTextfieldStatus_delete   表示是当前正在删除的状态
// KSAutoCompleteTextfieldStatus_complete 表示正在补全的状态
//
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, KSAutoCompleteTextfieldStatus)
{
    KSAutoCompleteTextfieldStatus_NA,
    KSAutoCompleteTextfieldStatus_input,
    KSAutoCompleteTextfieldStatus_delete,
    KSAutoCompleteTextfieldStatus_complete,
};
@interface KSAutoCompleteTextfield : UITextField

/**
 初始化函数
 @param  frame frame
 @param  字体大小
 @param  补全的大小
 */

- (id)initWithFrame:(CGRect)frame
           withFont:(UIFont*)font
  withCompleteColor:(UIColor*)completeColor;

/**
 补全调用的函数
 @param 补全的字符串，一般是当前输入的字符串
 @param 补全的前缀,通常是targetString的一部分
 */
- (void)completeWithTagrgetString:(NSString*)targetString
                 withPrefixString:(NSString*)prefixString;

/**
 继续用上次补全的字符串做补全
 */
- (void)completeLastCompleteWithPrefixString:(NSString*)prefixString;

/**
 清除补全的状态
 */
- (void)clearComplete;
@property(nonatomic,copy)NSString *completeString;
@property(nonatomic,assign)KSAutoCompleteTextfieldStatus status;
@end
