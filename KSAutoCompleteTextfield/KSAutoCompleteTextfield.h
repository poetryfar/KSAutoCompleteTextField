//
//  KSAutoCompleteTextfield.h
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
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


- (id)initWithFrame:(CGRect)frame
           withFont:(UIFont*)font
  withCompleteColor:(UIColor*)completeColor;

- (void)completeWithTagrgetString:(NSString*)targetString
                 withPrefixString:(NSString*)prefixString;

- (void)completeLastCompleteWithPrefixString:(NSString*)prefixString;
- (void)clearComplete;
@property(nonatomic,copy)NSString *completeString;
@property(nonatomic,assign)KSAutoCompleteTextfieldStatus status;
@end
