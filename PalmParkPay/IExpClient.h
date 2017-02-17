//
//  IExpClient.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/23.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderEntity.h"
#import "IWXClient.h"
@class PalmParkExpKit;

@interface IExpClient : IWXClient{
    NSString* userid;
    NSString* password;
    OrderEntity* debitEntity;
    NSURLSessionDataTask *task;
}

@property (nonatomic) PalmParkExpKit* parent;


/**生成支付客户端*/
+(id) clientWithParent:(PalmParkExpKit*)parent user:(NSString*)userid password:(NSString*)password;
/**设置提现信息*/
-(void)setDebitEntity:(OrderEntity *)entity;
/**获取订单状态，目前只能获取未支付的订单*/
-(void)asyncScheduleOfExpLists;
/**调起提现*/
-(void)asyncExportCash:(NSObject*)orderEntity;
/**授权当前用户，用以支付，只支付微信*/
-(void)asyncAuthorCurUser;
/**获取所有授权用户，用以提现*/
-(void)asyncHisUsers;
/***********************以下是提现的回调事件***********************/
/** 查询订单进度 */
-(void)scheduleOfExpLists:(NSArray*)orders status:(NSInteger)code msg:(NSString*)msg;
/** 当前授权用户 */
-(void)authorUser:(NSObject*)user status:(NSInteger)code msg:(NSString*)msg;
/** 历史授权用户 */
-(void)authorHisUsers:(NSArray*)users;
/** 提现进度查询 */
-(void)expStatus:(NSInteger)code msg:(NSString*)msg;
@end
