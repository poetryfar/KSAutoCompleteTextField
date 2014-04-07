//
//  KSAutoCompleteTextfieldDelegate.m
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import "KSAutoCompleteTextfieldDelegate.h"
#import "KSAutoCompleteTextfield.h"
#import "NSString+filt.h"
#import "KSAutoCompleteDataSource.h"
#define KSAutoCompleteTextQueryTimeInterval  .3f
#define KSAutoComplateTextQueryStringKey @"KSAutoComplateTextQueryStringKey"
@interface KSAutoCompleteTextfieldDelegate()
{
    
}
@property(nonatomic,retain)KSAutoCompleteDataSource *dataSource;
@property(nonatomic,copy)NSString *lastEnterString;
@property(nonatomic,copy)NSString *lastQueryString;
@property(nonatomic,retain)NSTimer *queryTimer;
@end
@implementation KSAutoCompleteTextfieldDelegate


- (id)init
{
    self = [super init];
    if (self) {
        self.dataSource = [[[KSAutoCompleteDataSource alloc]init] autorelease];
    }
    return self;
}

- (void)dealloc
{
    [self queryTimerStop];
    [super dealloc];
}


- (void)textChanged:(NSNotification*)notification
{
    KSAutoCompleteTextfield *textfield = [notification object];
    //如果当前文本和上次是一样的直接忽略
    if ([[textfield text] isEqualToString:self.lastEnterString]){
        return;
    }
    self.lastEnterString = [textfield text];
    
    NSString *filtedString = [[textfield text]  stringFilt];
    if ([filtedString isEqualToString:self.lastQueryString]){
        [textfield completeLastCompleteWithPrefixString:filtedString];
        return;
    }
    if (nil != self.lastQueryString) {
        NSRange lastQueryRange = [filtedString rangeOfString:self.lastQueryString];
        if (lastQueryRange.length > 0 && self.autoCompleteTextfield.status == KSAutoCompleteTextfieldStatus_complete) {
            NSRange filtRange = [self.autoCompleteTextfield.completeString rangeOfString:filtedString options:NSCaseInsensitiveSearch];
            if (filtRange.length > 0) {
                [textfield completeLastCompleteWithPrefixString:filtedString];
                self.autoCompleteTextfield.status = KSAutoCompleteTextfieldStatus_complete;
            }
            else{
                [self.autoCompleteTextfield clearComplete];
                self.autoCompleteTextfield.status = KSAutoCompleteTextfieldStatus_input;
            }
            return;
        }
    }
    self.lastQueryString = filtedString;
    if (self.autoCompleteTextfield.status == KSAutoCompleteTextfieldStatus_input) {
        [self startQueryTimerWithQueryString:filtedString];
    }
    
}

- (void)queryTimerStop
{
    [self.queryTimer invalidate];
    self.queryTimer = nil;
}

- (void)startQueryTimerWithQueryString:(NSString*)filtedString
{
    [self queryTimerStop];
    self.queryTimer = [NSTimer scheduledTimerWithTimeInterval:KSAutoCompleteTextQueryTimeInterval
                                                       target:self
                                                     selector:@selector(queryWithString:)
                                                     userInfo:@{KSAutoComplateTextQueryStringKey:filtedString}
                                                      repeats:NO];
}

- (void)queryWithString:(id)sender
{
    NSString *queryString = [sender userInfo][KSAutoComplateTextQueryStringKey];
    if (queryString.length == 0){
        [self.autoCompleteTextfield clearComplete];
    }
    else{
        NSArray *queryResult  =  [self.dataSource queryWithString:queryString];
        if ([queryResult count] ==0) {
            [self.autoCompleteTextfield clearComplete];
            self.autoCompleteTextfield.status = KSAutoCompleteTextfieldStatus_input;
        }
        else{
            [self.autoCompleteTextfield completeWithTagrgetString:queryResult[0] withPrefixString:queryString];
            self.autoCompleteTextfield.status = KSAutoCompleteTextfieldStatus_complete;
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shuoldReplace = NO;
    switch (self.autoCompleteTextfield.status) {
        case KSAutoCompleteTextfieldStatus_input:
        case KSAutoCompleteTextfieldStatus_delete:
        {
            shuoldReplace = YES;
            if ([string length] >0) {
                self.autoCompleteTextfield.status = KSAutoCompleteTextfieldStatus_input;
            }
            else{
                self.autoCompleteTextfield.status = KSAutoCompleteTextfieldStatus_delete;
            }
        }
            break;
        case KSAutoCompleteTextfieldStatus_complete:
        {
            if ([string length] >0) {
                shuoldReplace = YES;
            }
            else{
                shuoldReplace = NO;
                [self.autoCompleteTextfield clearComplete];
                self.autoCompleteTextfield.status = KSAutoCompleteTextfieldStatus_input;
            }
        }
            break;
        default:
            break;
    }
    return shuoldReplace;
}


@end
