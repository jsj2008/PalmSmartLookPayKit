//
//  WXPayEntity.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/15.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  微信支付实例
 */
@interface WXPayEntity : NSObject
/**
 *  <#Description#>
 */
@property (retain,nonatomic)NSString* partnerid;
/**
 *  <#Description#>
 */
@property (retain,nonatomic)NSString* prepayid;
/**
 *  <#Description#>
 */
@property (retain,nonatomic)NSString* noncestr;
/**
 *  <#Description#>
 */
@property (nonatomic)unsigned int timestamp;
/**
 *  固定值
 */
@property (retain,nonatomic)NSString* package;
/**
 *  <#Description#>
 */
@property (retain,nonatomic)NSString* sign;
/**
 *  存储对象实例化
 *
 *  @param json <#json description#>
 *
 *  @return <#return value description#>
 */
+(id)fromJSON:(NSDictionary*)json;
@end
