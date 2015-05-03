//
//  KSAutoCompleteTextfieldDelegate.h
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSAutoCompleteTextfield;
@interface KSAutoCompleteTextfieldDelegate : NSObject<UITextFieldDelegate>


@property(nonatomic,assign)KSAutoCompleteTextfield *autoCompleteTextfield;
/**
 地址栏文本变化的回调
 */
- (void)textChanged:(NSNotification*)notification;
@end
