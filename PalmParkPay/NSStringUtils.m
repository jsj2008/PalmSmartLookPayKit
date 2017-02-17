//
//  NSStringUtils.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/9.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "NSStringUtils.h"

@implementation NSStringUtils
+(NSString *)replaceAll:(NSString *)str keys:(NSDictionary *)keys{
    NSInteger len = keys.allKeys.count;
    for (int i=0;i<len;i++) {
        NSString* key =keys.allKeys[i];
       NSString* val = keys[key];
       NSRange range = {0,str.length};
        str =  [str stringByReplacingOccurrencesOfString:key withString:val options:NSCaseInsensitiveSearch range:range];
    }
    return str;
}
@end
