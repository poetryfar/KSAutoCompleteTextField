//
//  NSString+URL.m
//  ksmobilebrowser
//
//  Created by pengbi on 3/18/13.
//  Copyright (c) 2013 Kingsoft. All rights reserved.
//

#import "NSString+filt.h"
@implementation NSString (URL)


- (NSString*)stringFilt
{
    NSMutableString *mutString = [[NSMutableString alloc]initWithString:self];
    [mutString replaceOccurrencesOfString:@"\u2006" withString:@"" options:0 range:NSMakeRange(0, self.length)];
    return mutString;
}


@end
