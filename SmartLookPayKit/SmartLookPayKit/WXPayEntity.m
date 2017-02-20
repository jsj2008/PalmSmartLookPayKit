//
//  WXPayEntity.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/15.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "WXPayEntity.h"

@implementation WXPayEntity

+(id)fromJSON:(NSDictionary *)dict{
    WXPayEntity *entity = [[WXPayEntity alloc]init];
    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    entity.partnerid           = [dict objectForKey:@"partnerid"];
    entity.prepayid            = [dict objectForKey:@"prepayid"];
    entity.noncestr            = [dict objectForKey:@"noncestr"];
    entity.timestamp           = stamp.intValue;
    entity.package             = [dict objectForKey:@"package"];
    entity.sign                = [dict objectForKey:@"sign"];
    return entity;
}
@end
