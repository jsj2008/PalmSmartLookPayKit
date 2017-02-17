//
//  PalmPayAPI.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//
#import <Foundation/Foundation.h>

#define HOST_DEFAULT @"www.tingber.com"

@class IWXClient;


@interface PalmParkAPI : NSObject{
    IWXClient *client;
}
/**
 *  单例化对象
 *
 *  @return <#return value description#>
 */
+(PalmParkAPI*)defaultAPI;
/**注册服务*/
-(void)registerApp;
/**
 *  设置回调接收对象
 *
 *  @param client <#client description#>
 */
-(void)setClient:(IWXClient*)client;
/**
 *  回调方法
 *
 *  @param url <#url description#>
 */
-(void)handleOpenURL:(NSURL *)url;
/**
 *  回调方法
 *
 *  @param url <#url description#>
 */
-(void)openURL:(NSURL *)url;
/**
 *  设置服务器地址
 *
 *  @param host 如www.tingber.com
 */
-(void)setServerHost:(NSString*)host;
/**
 *  获取服务器地址
 *
 *  @param host 如www.tingber.com
 */
-(NSString*)getServerHost;
@end
