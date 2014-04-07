//
//  KSAutoCompleteDataSource.h
//  KSAutoCompleteTextfield
//
//  Created by Cube on 14-1-28.
//  Copyright (c) 2014年 Cube. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSAutoCompleteDataSource : NSObject
- (NSArray*)queryWithString:(NSString*)queryString;
@end
