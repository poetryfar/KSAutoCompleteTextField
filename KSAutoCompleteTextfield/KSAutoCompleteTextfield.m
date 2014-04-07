//
//  KSAutoCompleteTextfield.m
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import "KSAutoCompleteTextfield.h"
@interface KSAutoCompleteTextfield()


@property(nonatomic,retain)UITextField *completeTextfield;
@property(nonatomic,retain)CALayer     *completeLayer;
@end

@implementation KSAutoCompleteTextfield

- (void)dealloc
{
    self.completeTextfield = nil;
    self.completeLayer     = nil;
#if  __has_feature(objc_arc)
    
#else
    [super dealloc];
#endif
#pragma TODO  释放property
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"点击我";
        
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame withFont:(UIFont *)font withCompleteColor:(UIColor *)completeColor
{
    self = [self initWithFrame:frame];
    if (self) {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.completeLayer = [CALayer layer];
        self.completeLayer.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:self.completeLayer];
        self.status = KSAutoCompleteTextfieldStatus_input;
        
        self.font = font;
        [self setBackgroundColor:[UIColor clearColor]];
        self.completeTextfield = [[UITextField alloc]init];
        self.completeTextfield.font = self.font;
        [self addSubview:self.completeTextfield];
        [self.completeTextfield setFont:font];
        [self.completeTextfield  setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)completeLastCompleteWithPrefixString:(NSString *)prefixString
{
    [self completeWithTagrgetString:self.completeString withPrefixString:prefixString];
}

- (void)completeWithTagrgetString:(NSString *)targetString withPrefixString:(NSString *)prefixString
{
    NSRange prefixRange = [targetString rangeOfString:prefixString options:NSCaseInsensitiveSearch];
    if (prefixRange.location != NSNotFound && prefixRange.length != targetString.length)
    {
        CGRect bounds = self.bounds;
        self.completeString = targetString;
        NSString *suffixString = [targetString substringFromIndex:prefixRange.location + prefixRange.length];
        [self.completeTextfield setText:suffixString];
        UITextRange* textRange= [self textRangeFromPosition:[self beginningOfDocument]
                                           toPosition:[self endOfDocument]];
        CGRect  prefixRect = [self firstRectForRange:textRange];
        CGSize suffixSize = [suffixString sizeWithFont:self.font constrainedToSize:CGSizeMake(NSIntegerMax, prefixRect.size.height)];
        float w=self.bounds.size.width-(prefixRect.origin.x + prefixRect.size.width);
        w=MIN(w, suffixSize.width);
        CGRect suffixRect = CGRectMake(prefixRect.origin.x + prefixRect.size.width,
                                    0,
                                    w,
                                    bounds.size.height);
        CGRect layerRect = CGRectMake(prefixRect.origin.x + prefixRect.size.width, [self curserRect].origin.y, w, [self curserRect].size.height);
        [self.completeLayer setFrame:layerRect];
        [self.completeTextfield setFrame:suffixRect];
        self.completeString = targetString;
        self.completeTextfield.hidden = NO;
        self.completeLayer.hidden = NO;
    }
    else{
        [self clearComplete];
    }
}

- (void)clearComplete
{
    self.completeString = nil;
    self.completeTextfield.hidden = YES;
    self.completeLayer.hidden = YES;
}

- (CGRect)curserRect
{
    static CGRect rect;
    if (CGRectEqualToRect(rect, CGRectZero)) {
        rect = [self caretRectForPosition:[self beginningOfDocument]];
    }
    return rect;
}


@end
