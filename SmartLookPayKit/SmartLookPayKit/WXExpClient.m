//
//  WXExpClient.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/24.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "WXExpClient.h"
#import "PalmPayUrls.h"
#import "ExpScheduleEntity.h"
#import "WXExpEntity.h"
#import "PalmParkAPI.h"

@implementation WXExpClient{
    NSString *filePath;
}
+(id)clientWithParent:(PalmParkExpKit *)parent user:(NSString *)userid password:(NSString *)password{
    WXExpClient* client = [[WXExpClient alloc]init];
    client.parent = parent;
    client->userid = userid;
    client->password = password;
    return client;
}
-(instancetype)init{
    self = [super init];
    NSString *documentDirectory =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    filePath = [documentDirectory stringByAppendingPathComponent:@"wxusercaches.plist"];
    return self;
}
-(void)asyncScheduleOfExpLists{
    if (!userid||!password){
        [self scheduleOfExpLists:nil status:900 msg:@"参数错误"];
        return;
    }
    NSMutableURLRequest *request= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getWxGetPayListUrl]]];
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
            [results addObject:[WXExpEntity entityWithString:arr[i]]];
        }
        [self authorHisUsers:results];
    });
}
-(void)asyncAuthorCurUser{
    SendAuthReq *req = [[SendAuthReq alloc]init];
    req.scope = @"snsapi_base,snsapi_userinfo";
    req.state = [NSString stringWithFormat:@"%ld",random()];
    [WXApi sendReq:req];
     [[PalmParkAPI defaultAPI] setClient:self];
}
-(void)asyncExportCash:(NSObject *)entity{
    if (!userid||!password||!debitEntity || !entity|| ![entity isKindOfClass:[WXExpEntity class]]) {
        [self scheduleOfExpLists:nil status:900 msg:@"参数错误"];
        return;
    }
    WXExpEntity* expEntity = (WXExpEntity*)entity;
    //存储账号信息
    [self saveExpEntity:expEntity];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[PalmPayUrls getWxTixianUrl]]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"client_ip=%@&userid=%@&totalFee=%d&remark=%@&openid=%@&password=%@",@"192.168.1.200",userid,debitEntity.price,debitEntity.title,expEntity.openId,password] dataUsingEncoding:NSUTF8StringEncoding];
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
-(void)saveExpEntity:(WXExpEntity *)entity{
    NSString* str = [entity toString];
    NSMutableArray *arrs = [NSMutableArray arrayWithContentsOfFile:filePath];
    if (arrs) {
    for (int i=0; i<arrs.count; i++) {
        if ([arrs[i] isEqualToString:str]) {
            [arrs removeObjectAtIndex:i];
            break;
        }
    }
    }else arrs = [NSMutableArray arrayWithCapacity:1];
    [arrs insertObject:[entity toString] atIndex:0];
    [arrs writeToFile:filePath atomically:YES];
}
-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp* r = (SendAuthResp*)resp;
        if (r.errCode == WXSuccess)
        [self getAccess_token:r.code];
        else
            [self authorUser:nil status:r.errCode msg:r.errStr];
    }
}
-(void)getAccess_token:(NSString*)code {
    NSString* url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", @"wx4aedcff6e12d7ffb", @"d4624c36b6795d1d99dcf0547af5443d", code];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
        if ([res statusCode] == 200) {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [self getUserInfo:dic[@"access_token"] openid:dic[@"openid"]];
        }else
            [self authorUser:nil status:[res statusCode]  msg:@"连接失败"];
    }];
    [task resume];
}

-(void)getUserInfo:(NSString*) token openid:(NSString*)openid {
   NSString* url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openid];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
        if ([res statusCode] == 200) {
            NSLog(@"status:%ld",(long)[res statusCode]);
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            WXExpEntity* entity = [WXExpEntity entityWithId:openid nickName:dic[@"nickname"]];
            [self saveExpEntity:entity];
            [self authorUser:entity status:200 msg:@"操作成功"];
        }else
            [self authorUser:nil status:[res statusCode]  msg:@"连接失败"];
    }];
 [task resume];
}
-(void)openURL:(NSURL *)url{
    [WXApi handleOpenURL:url delegate:self];
}
@end
