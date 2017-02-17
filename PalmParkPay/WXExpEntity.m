//
//  WXExpEntity
//  PalmParkPay
//
//  Created by 谭其勇 on 15/12/14.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "WXExpEntity.h"

@implementation WXExpEntity
+(WXExpEntity *)entityWithId:(NSString *)openId nickName:(NSString *)nickName{
    WXExpEntity* entity = [[WXExpEntity alloc]init];
    entity.openId = openId;
    entity.nickName = nickName;
    return entity;
}
+(WXExpEntity *)entityWithString:(NSString *)str{
    WXExpEntity* entity = [[WXExpEntity alloc]init];
    if (str) {
      NSArray* strs = [str componentsSeparatedByString:@"#PALM#"];
        entity.nickName = strs[0];
        entity.openId = strs[1];
    }
    return entity;

}
-(NSString *)toString{
    return [NSString stringWithFormat:@"%@#PALM#%@",self.nickName,self.openId];
}
@end
