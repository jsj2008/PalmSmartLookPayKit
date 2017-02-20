//
//  WXPayClient.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "WXPayClient.h"
#import "PalmPayUrls.h"
#import "NSStringUtils.h"
#import "WXPayEntity.h"

@implementation WXPayClient{
    NSURLSessionDataTask *task;
}
-(void)asyncScheduleOfPayLists{
    if (!userid||!password) {
        [self scheduleOfPayLists:nil status:900 msg:@"参数错误"];
        return;
    }
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getWxGetPayListUrl]]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"orderType=%i&userid=%@&password=%@",2,userid,password] dataUsingEncoding:NSUTF8StringEncoding];
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
        if ([res statusCode] == 200) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *return_code = dic[@"return_code"];
            if (return_code.intValue ==200) {
                NSArray* datas = dic[@"data"];
                NSMutableArray * results = [NSMutableArray array];
                for (NSDictionary *item in datas) {
                    WXPayEntity *entity = [WXPayEntity fromJSON:item];
                    [results addObject:entity];
                }
                [self scheduleOfPayLists:results status:200 msg:@"请求成功"];
            }else
                [self scheduleOfPayLists:nil status:return_code.intValue msg:dic[@"return_msg"]];
        }else
            [self scheduleOfPayLists:nil status:[res statusCode] msg:@"连接失败"];
    }];
    [task resume];
}
-(void)pay:(NSObject *)entity{
    if (!entity) {
        [self payStatus:900 msg:@"参数错误"];
        return;
    }
    if ([entity isKindOfClass:WXPayEntity.class]) {
        [self callPay:(WXPayEntity*)entity];
    }else if ([entity isKindOfClass:OrderEntity.class]) {
        OrderEntity* orderEntity = (OrderEntity*)entity;
        NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getWxCreateOrderUrl]]];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [[NSString stringWithFormat:@"client_ip=%@&outTradeNo=%@&userid=%@&password=%@&remark=%@&totalFee=%i",@"192.168.1.101",orderEntity.tradeNo,userid,password,orderEntity.title,orderEntity.price] dataUsingEncoding:NSUTF8StringEncoding];
        task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
            NSInteger code = [res statusCode];
            if (code == 200) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if(dict != nil){
                    NSString* retcode = dict[@"return_code"];
                    if (retcode.integerValue == 200){
                        NSArray *datas = dict[@"data"];
                        if (datas.count>0) {
                            NSDictionary *order = datas[0];
                            WXPayEntity* entity = [WXPayEntity fromJSON:order];
                            [self pay:entity];
                        }else
                            [self createPayList:nil status:retcode.integerValue msg:dict[@"return_msg"]];
                    }else
                        [self createPayList:nil status:retcode.integerValue msg:dict[@"return_msg"]];
                }
            }else
                [self createPayList:nil status:code msg:@"服务器返回错误"];
        }];
        [task resume];
    }else
        [self payStatus:900 msg:@"参数错误"];
}
-(void)callPay:(WXPayEntity*)entity{
    if (!entity) {
        [self payStatus:900 msg:@"参数错误"];
        return;
    }
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           =entity.partnerid;
    req.prepayId            = entity.prepayid;
    req.nonceStr            = entity.noncestr;
    req.timeStamp           = entity.timestamp;
    req.package             = entity.package;
    req.sign                = entity.sign;
    [WXApi sendReq:req];
}

    /** 支付回调事件 */
-(void)onResp:(BaseResp *)resp{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:
                [self payStatus:200 msg:@"支付成功"];
                break;
            default:
                [self payStatus:800 msg:[NSString stringWithFormat:@"支付失败，retcode = %d, retstr = %@", resp.errCode,resp.errStr]];
                break;
        }
    }
}

-(void)handleOpenURL:(NSURL *)url{
    [WXApi handleOpenURL:url delegate:self];
}
-(void)openURL:(NSURL *)url{
    [WXApi handleOpenURL:url delegate:self];
}

@end
