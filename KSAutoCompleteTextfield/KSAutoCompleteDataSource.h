//
//  KSAutoCompleteDataSource.h
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSAutoCompleteDataSource : NSObject
/**
 查询 某个字符串存在的数据集合，这个查询可以做的非常复杂，这只是一个简单的查找
 比如你可以调用baidu 的数据查询天气，可以查询用户的书签，历史等等
 @param queryString 要查询的字符串
 */
- (NSArray*)queryWithString:(NSString*)queryString;
@end
