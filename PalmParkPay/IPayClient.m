//
//  IPayClient.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/1.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "IPayClient.h"
#import "PalmParkPayKit.h"
//#import "IWXClient.h"

@implementation IPayClient
+(id)clientWithParent:(PalmParkPayKit *)parent user:(NSString*)userid password:(NSString*)password{
  IPayClient* client = [[super alloc]init];
    client.parent = parent;
    client->userid = userid;
    client->password = password;
    return client;
}

-(void)scheduleOfPayLists:(NSArray *)orders status:(NSInteger)code msg:(NSString *)msg{
     if (self.parent && self.parent.delegate)
         [self.parent.delegate payKit:self.parent scheduleOfPayLists:orders status:code msg:msg];
}
-(void)createPayList:(NSObject *)order status:(NSInteger)code msg:(NSString *)msg{
    if (self.parent && self.parent.delegate)
        [self.parent.delegate payKit:self.parent createPayList:order status:code msg:msg];
}
-(void)payStatus:(NSInteger)code msg:(NSString *)msg{
    if (self.parent && self.parent.delegate)
        [self.parent.delegate payKit:self.parent payStatus:code msg:msg];
}
@end
