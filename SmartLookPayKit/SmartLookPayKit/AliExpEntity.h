//
//  AliExpEntity.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/23.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  支付宝提现基础类
 */
@interface AliExpEntity : NSObject
/**
 *  支付宝实名
 */
@property (nonatomic,retain) NSString* username;
/**
 *  支付宝id,如123@126.com
 */
@property (nonatomic,retain) NSString* userid;
/**
 *  使用id和name初始化对象
 *
 *  @param uid   <#uid description#>
 *  @param uname <#uname description#>
 *
 *  @return <#return value description#>
 */
+(AliExpEntity*)entityWithUserId:(NSString*)uid name:(NSString*)uname;
/**
 *  此方法仅供内部使用
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(AliExpEntity*)entityWithString:(NSString*)str;

-(NSString*)toString;
@end
