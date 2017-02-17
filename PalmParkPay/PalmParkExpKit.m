//
//  PalmPayExpKit.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/14.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "PalmParkExpKit.h"
#import "PalmPayUrls.h"
#import "WXExpClient.h"
#import "AliExpClient.h"
#import "WXExpEntity.h"
#import "AliExpEntity.h"

@implementation PalmParkExpKit{
    NSURLSessionDataTask *task;
    AliExpClient* aliClient;
    WXExpClient* wxClient;
}
+(id)kitWithUser:(NSString*)us password:(NSString*)pwd{
    PalmParkExpKit* kit = [[PalmParkExpKit alloc]init];
    kit->userid = us;
    kit->password = pwd;
    kit->aliClient = [AliExpClient clientWithParent:kit user:us password:pwd];
    kit->wxClient = [WXExpClient clientWithParent:kit user:us password:pwd];
    return kit;
}

-(void)setDebitInfo:(OrderEntity *)entity{
    aliClient.debitEntity = entity;
    wxClient.debitEntity = entity;
}

-(void)asyncAuthorWX{
    [wxClient asyncAuthorCurUser];
}
-(void)asyncLoadHisUsersOfWX{
    [wxClient asyncHisUsers];
}
-(void)asyncLoadHisUsersOfAli{
    [aliClient asyncHisUsers];
}

-(void)asyncExportCashToWX:(WXExpEntity *)entity{
    [wxClient asyncExportCash:entity];
}
-(void)asyncExportCashToALI:(AliExpEntity *)entity{
    [aliClient asyncExportCash:entity];
}
-(void)asyncQueryscheduleOfWXExportCash{
    [wxClient asyncScheduleOfExpLists];
}
-(void)asyncQueryscheduleOfAliExportCash{
    [aliClient asyncScheduleOfExpLists];
}
-(void)disappear{
    if (task) {
        [task cancel];
    }
}

@end
