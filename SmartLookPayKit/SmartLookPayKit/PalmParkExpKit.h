//
//  PalmPayExpKit.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/14.
//  Copyright © 2015年 谭其勇. All rights reserved.
//
#import <Foundation/Foundation.h>


@class AliExpEntity;
@class WXExpEntity;
@class PalmParkExpKit;
@class OrderEntity;
/**
 *  提现代理类
 */
@protocol PalmParkExpDelegate<NSObject>

/** 查询订单进度 */
-(void)expKit:(PalmParkExpKit*)kit scheduleOfExpLists:(NSArray*)orders status:(NSInteger)code msg:(NSString*)msg;
/** 当前授权用户 */
-(void)expKit:(PalmParkExpKit*)kit authorUser:(NSObject*)user status:(NSInteger)code msg:(NSString*)msg;
/** 历史授权用户 */
-(void)expKit:(PalmParkExpKit*)kit authorHisUsers:(NSArray*)users;
/** 提现进度查询 */
-(void)expKit:(PalmParkExpKit*)kit expStatus:(NSInteger)code msg:(NSString*)msg;

@end
/**
 *  提现入口类
 */
@interface PalmParkExpKit : NSObject{
    OrderEntity *debitEntity;
    id<PalmParkExpDelegate> delegate;
    NSString* userid;
    NSString* password;
}
@property (nonatomic) id<PalmParkExpDelegate> delegate;
/**创建提现Kit*/
+(id)kitWithUser:(NSString*)userid password:(NSString*)password;
/**设置提现信息,提现金额不能小于100分*/
-(void)setDebitInfo:(OrderEntity*)entity;
/**异步获取当前微信用户信息，用于提现*/
-(void)asyncAuthorWX;
/**获取微信授权历史*/
-(void)asyncLoadHisUsersOfWX;
/**获取支付宝授权历史*/
-(void)asyncLoadHisUsersOfAli;
/**提现至微信*/
-(void)asyncExportCashToWX:(WXExpEntity*)entity;
/**提现至支付宝*/
-(void)asyncExportCashToALI:(AliExpEntity*)entity;
/**微信提现进度查询*/
-(void)asyncQueryscheduleOfWXExportCash;
/**支付宝提现进度查询*/
-(void)asyncQueryscheduleOfAliExportCash;
/**
 *  回收资源
 */
-(void)disappear;
@end
