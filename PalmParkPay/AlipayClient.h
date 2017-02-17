//
//  AlipayClient.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "IPayClient.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "AliPayEntity.h"
/**
 *支付宝支付客户端
 *
 */
@interface AlipayClient : IPayClient

@end
