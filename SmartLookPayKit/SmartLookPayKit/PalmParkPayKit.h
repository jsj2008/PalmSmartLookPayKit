//
//  PalmPay.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PalmParkPayKit;
@class AlipayClient;
@class WXPayClient;
@class AliPayEntity;
@class WXPayEntity;
/**
 *  支付代理类
 */
@protocol PalmParkPayDelegate <NSObject>
/** 查询订单进度 */
-(void)payKit:(PalmParkPayKit*)sender scheduleOfPayLists:(NSArray*)orders status:(NSInteger)code msg:(NSString*)msg;
/** 生成支付订单 */
-(void)payKit:(PalmParkPayKit*)sender createPayList:(NSObject*)order status:(NSInteger)code msg:(NSString*)msg;
/** 支付订单 */
-(void)payKit:(PalmParkPayKit*)sender payStatus:(NSInteger)code msg:(NSString*)msg;
@end
/**
 *  支付入口类
 */
@interface PalmParkPayKit : NSObject{
    AlipayClient *alipayClient;
    WXPayClient *wxpayClient;
    OrderEntity* orderEntity;
    NSString* userid;
    NSString* password;
}
/**支付回调*/
@property (retain,nonatomic) id<PalmParkPayDelegate> delegate;

/**获取支付Kit*/
+(id)kitWithUser:(NSString*)userid password:(NSString*)password;
/**设置支付信息*/
-(void)setOrder:(OrderEntity*) orderEntity;
/**异步获取微信未支付订单*/
-(void)asyncPayListsOfWX;
/**异步获取支付宝未支付订单*/
-(void)asyncPayListsOfAli;
/**调用微信支付，支付未完成订单*/
-(void)wxPay:(WXPayEntity*)entity;
/**调用支付宝支付，支付未完成订单*/
-(void)aliPay:(AliPayEntity*)entity;
/**调用微信支付，开启新支付*/
-(void)wxPay;
/**调用支付宝支付，开启新支付*/
-(void)aliPay;
/**diddisappear时回调此方法*/
-(void)disappear;
@end
