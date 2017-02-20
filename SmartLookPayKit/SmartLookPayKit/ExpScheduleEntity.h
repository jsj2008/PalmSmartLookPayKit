//
//  ExpScheduleEntity.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/24.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  提现进度类
 */
@interface ExpScheduleEntity : NSObject
/**
 *  提现订单号
 */
@property (nonatomic,retain) NSString* prepayid;
/**
 *  提现金额
 */
@property (nonatomic,retain) NSString* total_fee;
/**
 *  提现时间
 */
@property (nonatomic,retain) NSString* timestamp;
/**
 *  提现状态
 */
@property (nonatomic,retain) NSString* pay_status;
/**
 *  提现状态描述
 */
@property (nonatomic,retain) NSString* pay_status_msg;
/**
 *  从json序列化为实例对象
 *
 *  @param str json对象
 *
 *  @return 
 */
+(id)entityWithJSON:(NSDictionary*)str;

-(NSString*)getPayStatusMsg;
@end
