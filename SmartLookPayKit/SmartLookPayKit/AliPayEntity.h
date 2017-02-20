//
//  AliPayEntity.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/23.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  支付宝支付实例类
 */
@interface AliPayEntity : NSObject
/**
 *  数据编码类型
 */
@property (nonatomic,retain) NSString* _input_charset;
/**
 *  私钥
 */
@property (nonatomic,retain) NSString* private_key;
/**
 *  支付金额
 */
@property (nonatomic) int total_fee;
/**
 *  支付描述
 */
@property (nonatomic,retain) NSString* subject;
/**
 *  通知地址
 */
@property (nonatomic,retain) NSString* notify_url;
/**
 *  支付订单（商家订单）
 */
@property (nonatomic,retain) NSString* outTradeNo;
/**
 *  有效期
 */
@property (nonatomic,retain) NSString* valid_period;
/**
 *  收款方
 */
@property (nonatomic,retain) NSString* seller_id;
/**
 *  合伙人ID
 */
@property (nonatomic,retain) NSString* partner;
/**
 *  将服务器回传信息封装成实例
 *
 *  @param dic <#dic description#>
 *
 *  @return <#return value description#>
 */
+(AliPayEntity*)entityWithJSON:(NSDictionary*)dic;
@end
