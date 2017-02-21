//
//  AliExpEntity.m
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/23.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "AliExpEntity.h"

@implementation AliExpEntity

+(AliExpEntity *)entityWithUserId:(NSString *)uid name:(NSString *)uname{
    AliExpEntity* entity = [[AliExpEntity alloc]init];
    entity.userid = uid;
    entity.username = uname;
    return entity;
}

+(AliExpEntity *)entityWithString:(NSString *)str{
    AliExpEntity* entity = [[AliExpEntity alloc]init];
    if (str) {
        NSArray* arr = [str componentsSeparatedByString:@"^"];
        if (arr.count==1) {
            entity.userid = arr[0];
        }else if (arr.count==2) {
            entity.userid = arr[0];
             entity.username = arr[1];
        }
    }
    return entity;
}

-(NSString *)toString{
    return [NSString stringWithFormat:@"%@^%@",self.userid,self.username];
}

@end
