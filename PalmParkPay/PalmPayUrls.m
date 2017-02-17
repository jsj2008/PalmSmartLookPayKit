//
//  PalmPayUrls.m
//  PalmParkPay
//
//  Created by 谭其勇 on 16/1/30.
//  Copyright © 2016年 谭其勇. All rights reserved.
//

#import "PalmPayUrls.h"
#import "PalmParkAPI.h"
#define WX_TIXIAN_URL @"/payservice/preorder/wxwithdraworder.do"
#define ALI_TIXIAN_URL @"/payservice/preorder/aliwithdraworder.do"
#define WX_GET_PAYLIST_URL @"/payservice/preorder/wxqueryorder.do"
#define ALI_GET_PAYLIST_URL @"/payservice/preorder/aliqueryorder.do"
#define WX_CREATE_ORDER_URL @"/payservice/preorder/wxunifiedorder.do"
#define ALI_CREATE_ORDER_URL @"/payservice/preorder/aliunifiedorder.do"

@implementation PalmPayUrls
+(NSString *)getWxTixianUrl{
    return [NSString stringWithFormat:@"http://%@%@",[[PalmParkAPI defaultAPI] getServerHost],WX_TIXIAN_URL];
}
+(NSString *)getWxGetPayListUrl{
     return [NSString stringWithFormat:@"http://%@%@",[[PalmParkAPI defaultAPI] getServerHost],WX_GET_PAYLIST_URL];
}
+(NSString *)getWxCreateOrderUrl{
    return [NSString stringWithFormat:@"http://%@%@",[[PalmParkAPI defaultAPI] getServerHost],WX_CREATE_ORDER_URL];
}
+(NSString *)getAliTixianUrl{
    return [NSString stringWithFormat:@"http://%@%@",[[PalmParkAPI defaultAPI] getServerHost],ALI_TIXIAN_URL];
}
+(NSString *)getAliGetPayListUrl{
     return [NSString stringWithFormat:@"http://%@%@",[[PalmParkAPI defaultAPI] getServerHost],ALI_GET_PAYLIST_URL];
}
+(NSString *)getAliCreateOrderUrl{
     return [NSString stringWithFormat:@"http://%@%@",[[PalmParkAPI defaultAPI] getServerHost],ALI_CREATE_ORDER_URL];
}
@end
