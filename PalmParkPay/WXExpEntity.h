//
//  WXDebitEntity.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/14.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  微信提现实例
 */
@interface WXExpEntity : NSObject
/**
 *  微信账号基于商家的授权ID
 */
@property (retain,nonatomic)NSString* openId;
/**
 *  微信昵称
 */
@property (retain,nonatomic)NSString* nickName;

+(WXExpEntity*)entityWithId:(NSString*)openId nickName:(NSString*) nickName;
/**
 *  存储对象实例化
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(WXExpEntity*)entityWithString:(NSString*)str;
/**
 *  实例序列化以便存储
 *
 *  @return <#return value description#>
 */
-(NSString*)toString;
@end
