//
//  IWXClient.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/14.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *支付回调
 *
 */
@interface IWXClient : NSObject
/**
 *  支付宝和微信的回调方法
 *
 *  @param url <#url description#>
 */
-(void)handleOpenURL:(NSURL *)url;
/**
 *  支付宝和微信的回调方法
 *
 *  @param url <#url description#>
 */
-(void)openURL:(NSURL *)url;

@end
