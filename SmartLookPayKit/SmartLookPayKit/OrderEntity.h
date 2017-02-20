//
//  OrderEntity.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/2.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  订单信息
 */
@interface OrderEntity : NSObject
/**金额（单位：分）*/
@property (nonatomic)int price;
/**主要标题*/
@property (nonatomic,retain)NSString* title;
/**订单号*/
@property (nonatomic,retain)NSString* tradeNo;
/**订单详情*/
@property (nonatomic,retain)NSString* detail;

@end
