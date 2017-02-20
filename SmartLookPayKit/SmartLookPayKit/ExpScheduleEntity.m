//
//  ExpScheduleEntity.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/24.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "ExpScheduleEntity.h"

@implementation ExpScheduleEntity
+(id)entityWithJSON:(NSDictionary *)dic{
    ExpScheduleEntity* entity = [[ExpScheduleEntity alloc]init];
    if (dic) {
        entity.prepayid = dic[@"prepayid"];
        entity.total_fee = dic[@"total_fee"];
        entity.timestamp = dic[@"timestamp"];
        entity.pay_status = dic[@"pay_status"];
    }
    return entity;
}
-(NSString *)getPayStatusMsg{
    switch ([self.pay_status intValue]) {
        case 1:
            return @"预支付";
        case 2:
            return @"支付中";
        case 3:
            return @"支付成功";
        case -1:
            return @"支付失败";
        default:
            return @"预支付";
    }
}
@end
