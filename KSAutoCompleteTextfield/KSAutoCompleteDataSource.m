//
//  KSAutoCompleteDataSource.m
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import "KSAutoCompleteDataSource.h"

@implementation KSAutoCompleteDataSource


- (NSArray*)exampleDataArray
{
    static NSArray *urlArray;
    if (!urlArray) {
        urlArray =  [@[@"sina.com",
                        @"baidu.com",
                       @"yahoo.com"
                       ,@"google.com"]retain];
    }
   return urlArray;


}
- (NSArray*)queryWithString:(NSString*)queryString
{
    NSMutableArray *resultArray = [NSMutableArray array];
    for (NSString *string in [self exampleDataArray]) {
        NSRange range = [string rangeOfString:queryString options:NSCaseInsensitiveSearch];
        if (range.length > 0) {
            [resultArray addObject:string];
        }
    }
    return [resultArray count] > 0?resultArray:nil;
}
@end
