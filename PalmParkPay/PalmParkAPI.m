//
//  PalmPayAPI.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "PalmParkAPI.h"
#import "IPayClient.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

static PalmParkAPI *api;
@implementation PalmParkAPI{
    NSString* h;
}
+(PalmParkAPI *)defaultAPI{
    if (!api) {
        api = [[PalmParkAPI alloc] init];
    }
    return api;
}
-(void)setClient:(IWXClient *)c{
    client = c;
}
-(void)registerApp{
    [WXApi registerApp:@"wx4aedcff6e12d7ffb"];
}
-(void)handleOpenURL:(NSURL *)url{
    if (client)
       [client handleOpenURL:url];
}
-(void)openURL:(NSURL *)url{
    if (client)
        [client openURL:url];
}

-(void)setServerHost:(NSString *)host{
    h= host;
}
-(NSString*)getServerHost{
    if (h && ![@"" isEqualToString:h]) {
        return h;
    }
    return HOST_DEFAULT;
}
@end
