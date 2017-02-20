//
//  IPayClient.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderEntity.h"
#import "IWXClient.h"

@class PalmParkPayKit;
/**
 *支付基类
 *
 */
@interface IPayClient : IWXClient{
    NSString* userid;
    NSString* password;
}

@property (nonatomic) PalmParkPayKit* parent;

/**生成支付客户端*/
+(id) clientWithParent:(PalmParkPayKit*)parent user:(NSString*)userid password:(NSString*)password;
/**获取订单状态，目前只能获取未支付的订单*/
-(void)asyncScheduleOfPayLists;
/**调起支付*/
-(void)pay:(NSObject*)orderEntity;
/**
 *  回调
 *
 *  @param orders <#orders description#>
 *  @param code   <#code description#>
 *  @param msg    <#msg description#>
 */
-(void)scheduleOfPayLists:(NSArray*)orders status:(NSInteger)code msg:(NSString*)msg;
/**
 *  回调
 *
 *  @param order <#order description#>
 *  @param code  <#code description#>
 *  @param msg   <#msg description#>
 */
-(void)createPayList:(NSObject*)order status:(NSInteger)code msg:(NSString*)msg;
/**
 *  回调
 *
 *  @param code <#code description#>
 *  @param msg  <#msg description#>
 */
-(void)payStatus:(NSInteger)code msg:(NSString*)msg;

@end
