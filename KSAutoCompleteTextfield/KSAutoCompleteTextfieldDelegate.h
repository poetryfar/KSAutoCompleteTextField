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
- (void)textChanged:(NSNotification*)notification;
@end
