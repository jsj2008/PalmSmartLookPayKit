//
//  IExpClient.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/23.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "IExpClient.h"
#import "PalmParkExpKit.h"
@implementation IExpClient
+(id)clientWithParent:(PalmParkExpKit *)parent user:(NSString *)userid password:(NSString *)password{
    IExpClient* client = [[IExpClient alloc]init];
    client.parent = parent;
    client->userid = userid;
    client->password = password;
    return client;
}
-(void)scheduleOfExpLists:(NSArray *)orders status:(NSInteger)code msg:(NSString *)msg{
    if (self.parent && self.parent.delegate)
        [self.parent.delegate expKit:self.parent scheduleOfExpLists:orders status:code msg:msg];
}
-(void)authorHisUsers:(NSArray *)users{
    if (self.parent && self.parent.delegate)
        [self.parent.delegate expKit:self.parent authorHisUsers:users];
}
-(void)authorUser:(NSObject *)user status:(NSInteger)code msg:(NSString *)msg{
    if (self.parent && self.parent.delegate)
        [self.parent.delegate expKit:self.parent authorUser:user status:code msg:msg];
}
-(void)expStatus:(NSInteger)code msg:(NSString *)msg{
    if (self.parent && self.parent.delegate)
        [self.parent.delegate expKit:self.parent expStatus:code msg:msg];
}
-(void)setDebitEntity:(OrderEntity *)entity{
    debitEntity = entity;
}
@end
