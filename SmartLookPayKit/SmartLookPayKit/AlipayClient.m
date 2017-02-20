//
//  AlipayClient.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "AlipayClient.h"
#import "PalmPayUrls.h"
#import "DataSigner.h"

@implementation AlipayClient{
    NSURLSessionDataTask *task ;
}

-(void)asyncScheduleOfPayLists{
    if (!userid||!password){
        [self scheduleOfPayLists:nil status:900 msg:@"参数错误"];
        return;
    }
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getAliGetPayListUrl]]];
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
                    AliPayEntity *entity = [AliPayEntity entityWithJSON:item];
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
    if ([entity isKindOfClass:AliPayEntity.class]) {
        [self callPay:(AliPayEntity*)entity];
    }else if ([entity isKindOfClass:OrderEntity.class]) {
        OrderEntity* orderEntity = (OrderEntity*)entity;
        NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getAliCreateOrderUrl]]];
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
                            NSDictionary *data = datas[0];
                            AliPayEntity* entity = [AliPayEntity entityWithJSON:data];
                            [self callPay:entity];
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
-(void)callPay:(AliPayEntity *)entity{
    if (!entity) {
        [self payStatus:900 msg:@"参数错误"];
        return;
    }
    Order *order = [[Order alloc] init];
    order.partner = entity.partner;
    order.seller = entity.seller_id;
    order.tradeNO = entity.outTradeNo; //订单ID（由商家自行制定）
    order.productName = entity.subject; //商品标题
    //order.productDescription = self.orderEntity.detail; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",entity.total_fee/100.0]; //商品价格
    order.notifyURL = entity.notify_url; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = entity._input_charset;
    order.itBPay = entity.valid_period;
    NSString *appScheme = @"palmpay";
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    NSString *signedString = [CreateRSADataSigner(entity.private_key) signString:orderSpec];
    NSString *signedString = [CreateRSADataSigner(entity.private_key) signString:orderSpec];
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            [self showPayStatus:resultDic];
        }];
    }
}
-(void)openURL:(NSURL *)url{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             [self showPayStatus:resultDic];
         }];
    }
}
-(void)showPayStatus:(NSDictionary *)resultDic{
    NSInteger code = [resultDic[@"resultStatus"] integerValue];
    if (code==9000) {
        [self payStatus:0 msg:@"支付成功"];
    }else
        [self payStatus:[resultDic[@"resultStatus"] integerValue] msg:resultDic[@"memo"]];
}
@end
