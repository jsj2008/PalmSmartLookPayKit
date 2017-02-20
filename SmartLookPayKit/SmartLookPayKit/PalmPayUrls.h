//
//  PalmPayUrls.h
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/15.
//  Copyright © 2015年 谭其勇. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface PalmPayUrls:NSObject{
    NSString* h;
}

+(NSString*)getWxTixianUrl;
+(NSString*)getWxGetPayListUrl;
+(NSString*)getWxCreateOrderUrl;
+(NSString*)getAliTixianUrl;
+(NSString*)getAliGetPayListUrl;
+(NSString*)getAliCreateOrderUrl;

@end