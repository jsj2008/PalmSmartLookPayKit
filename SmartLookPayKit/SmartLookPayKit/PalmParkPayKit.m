//
//  PalmPay.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "PalmParkPayKit.h"
#import "PalmPayUrls.h"
#import "Order.h"
#import "AlipayClient.h"
#import "WXPayClient.h"
#import "IPayClient.h"
#import "PalmParkAPI.h"
#import "WXPayEntity.h"
#import "AliPayEntity.h"

@implementation PalmParkPayKit{
    NSURLSessionDataTask *task;
}

+(id)kitWithUser:(NSString*)userid password:(NSString*)password{
    PalmParkPayKit* kit = [[PalmParkPayKit alloc]init];
    kit->userid = userid;
    kit->password = password;
    kit->wxpayClient = [WXPayClient clientWithParent:kit user:userid password:password];
    kit->alipayClient = [AlipayClient clientWithParent:kit user:userid password:password];
    return kit;
}

-(void)setOrder:(OrderEntity *)order{
    orderEntity = order;
}

-(void)asyncPayListsOfWX{
    [wxpayClient asyncScheduleOfPayLists];
}
-(void)asyncPayListsOfAli{
    [alipayClient asyncScheduleOfPayLists];
}
-(void)wxPay:(WXPayEntity *)entity{
    [wxpayClient pay:entity];
    [[PalmParkAPI defaultAPI] setClient:wxpayClient];
}

-(void)wxPay{
    [wxpayClient pay:orderEntity];
    [[PalmParkAPI defaultAPI] setClient:wxpayClient];
}
-(void)aliPay:(AliPayEntity *)entity{
    [alipayClient pay:entity];
    [[PalmParkAPI defaultAPI] setClient:alipayClient];
}
-(void)aliPay{
    [alipayClient pay:orderEntity];
    [[PalmParkAPI defaultAPI] setClient:alipayClient];
}

-(void)disappear{
    if (task) {
        [task cancel];
    }
}
@end
