//
//  NSStringUtils.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/9.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  string操作增强类
 */
@interface NSStringUtils : NSObject
/**
 *  全文替换指定字符
 *
 *  @param str  <#str description#>
 *  @param keys <#keys description#>
 *
 *  @return <#return value description#>
 */
+(NSString*)replaceAll:(NSString*)str keys:(NSDictionary*)keys;
@end
