//
//  AliPayEntity.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/23.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "AliPayEntity.h"

@implementation AliPayEntity
+(AliPayEntity *)entityWithJSON:(NSDictionary *)dic{
    AliPayEntity * entity = [[AliPayEntity alloc]init];
    entity._input_charset = dic[@"_input_charset"];
    entity.private_key = dic[@"private_key"];
    entity.total_fee = [dic[@"total_fee"] intValue];
    entity.subject = dic[@"subject"];
    entity.notify_url = dic[@"notify_url"];
    entity.outTradeNo = dic[@"outTradeNo"];
    entity.valid_period = dic[@"valid_period"];
    entity.seller_id = dic[@"seller_id"];
    entity.partner = dic[@"partner"];
    return entity;
}
@end
