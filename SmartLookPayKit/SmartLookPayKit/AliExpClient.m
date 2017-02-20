//
//  AliExpClient.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/23.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "AliExpClient.h"
#import "PalmPayUrls.h"
#import "AliExpEntity.h"
#import "ExpScheduleEntity.h"

@implementation AliExpClient{
    NSString *filePath;
}
+(id)clientWithParent:(PalmParkExpKit *)parent user:(NSString *)userid password:(NSString *)password{
    AliExpClient* client = [[AliExpClient alloc]init];
    client.parent = parent;
    client->userid = userid;
    client->password = password;
    return client;
}
-(instancetype)init{
    self = [super init];
    NSString *documentDirectory =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
     filePath = [documentDirectory stringByAppendingPathComponent:@"aliusercaches.plist"];
    return self;
}
-(void)asyncScheduleOfExpLists{
    if (!userid||!password){
        [self scheduleOfExpLists:nil status:900 msg:@"参数错误"];
        return;
    }
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getAliGetPayListUrl]]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"orderType=%i&userid=%@&password=%@",3,userid,password] dataUsingEncoding:NSUTF8StringEncoding];
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
        if ([res statusCode] == 200) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *return_code = dic[@"return_code"];
            if (return_code.intValue ==200) {
                NSArray* datas = dic[@"data"];
                NSMutableArray * results = [NSMutableArray array];
                for (NSDictionary *item in datas) {
                    ExpScheduleEntity *entity = [ExpScheduleEntity entityWithJSON:item];
                    [results addObject:entity];
                }
                [self scheduleOfExpLists:results status:200 msg:@"请求成功"];
            }else
                [self scheduleOfExpLists:nil status:return_code.intValue msg:dic[@"return_msg"]];
        }else
            [self scheduleOfExpLists:nil status:[res statusCode] msg:@"连接失败"];
    }];
    [task resume];
}
-(void)asyncHisUsers{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
        NSMutableArray *results = [NSMutableArray array];
        for (int i=0; i<arr.count; i++) {
            [results addObject:[AliExpEntity entityWithString:arr[i]]];
        }
        [self authorHisUsers:results];
    });
}
-(void)asyncAuthorCurUser{
    [self authorUser:nil status:800 msg:@"支付宝不能调用此方法"];
}
-(void)asyncExportCash:(NSObject *)entity{
    if (!userid||!password||!debitEntity || !entity|| ![entity isKindOfClass:[AliExpEntity class]]) {
        [self scheduleOfExpLists:nil status:900 msg:@"参数错误"];
        return;
    }
    AliExpEntity* expEntity = (AliExpEntity*)entity;
    //存储账号信息
    [self saveExpEntity:expEntity];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getAliTixianUrl]]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"client_ip=%@&userid=%@&totalFee=%d&remark=%@&openid=%@&password=%@",@"192.168.1.200",userid,debitEntity.price,debitEntity.title,[expEntity toString],password] dataUsingEncoding:NSUTF8StringEncoding];
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
        if ([res statusCode] == 200) {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self expStatus:[dic[@"return_code"] integerValue]  msg:dic[@"return_msg"]];
        }else
            [self expStatus:[res statusCode]  msg:@"连接失败"];
    }];
    [task resume];
}
-(void)saveExpEntity:(AliExpEntity *)entity{
    NSMutableArray *arrs = [NSMutableArray arrayWithContentsOfFile:filePath];
    for (int i=0; i<arrs.count; i++) {
        if ([arrs[i] containsString:entity.userid]) {
            [arrs removeObjectAtIndex:i];
            break;
        }
    }
    [arrs insertObject:[entity toString] atIndex:0];
    [arrs writeToFile:filePath atomically:YES];
}
-(void)openURL:(NSURL *)url{
    
}
@end
