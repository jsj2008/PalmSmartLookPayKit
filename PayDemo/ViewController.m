//
//  ViewController.m
//  PayDemo
//
//  Created by 谭其勇 on 15/12/2.
//  Copyright © 2015年 谭其勇. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController{
    UIButton *btnAliPay;
    UIButton *btnWXPay;
    UILabel *showLab;
    PalmParkExpKit* expKit;
    PalmParkPayKit* payKit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect f = self.view.frame;
   UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    UIButton*  btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, f.size.width-20, 30)];
    [btn1 addTarget:self action:@selector(wxPayList:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"未完成支付订单-微信" forState:UIControlStateNormal];
    [btn1.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn1.layer setBorderWidth:1];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    //
    UIButton*  btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 70, f.size.width-20, 30)];
    [btn2 addTarget:self action:@selector(aliPayList:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"未完成支付订单-支付宝" forState:UIControlStateNormal];
    [btn2.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn2.layer setBorderWidth:1];
    [btn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
  UIButton*  btn3 = [[UIButton alloc]initWithFrame:CGRectMake(10, 110, f.size.width-20, 30)];
    [btn3 addTarget:self action:@selector(wxPay:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"支付-微信" forState:UIControlStateNormal];
    [btn3.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn3.layer setBorderWidth:1];
    [btn3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    //
    UIButton*  btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 150, f.size.width-20, 30)];
    [btn4 addTarget:self action:@selector(aliPay:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"支付-支付宝" forState:UIControlStateNormal];
    [btn4.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn4.layer setBorderWidth:1];
    [btn4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    UIButton* btn5 = [[UIButton alloc]initWithFrame:CGRectMake(10, 190, f.size.width-20, 30)];
    [btn5 addTarget:self action:@selector(authorWX:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 setTitle:@"授权-微信" forState:UIControlStateNormal];
    [btn5.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn5.layer setBorderWidth:1];
    [btn5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    UIButton* btn6 = [[UIButton alloc]initWithFrame:CGRectMake(10, 230, f.size.width-20, 30)];
    [btn6 addTarget:self action:@selector(expHisWX:) forControlEvents:UIControlEventTouchUpInside];
    [btn6 setTitle:@"历史提现用户-微信" forState:UIControlStateNormal];
    [btn6.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn6.layer setBorderWidth:1];
    [btn6 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    UIButton* btn7 = [[UIButton alloc]initWithFrame:CGRectMake(10, 270, f.size.width-20, 30)];
    [btn7 addTarget:self action:@selector(expHisAli:) forControlEvents:UIControlEventTouchUpInside];
    [btn7 setTitle:@"历史提现用户-支付宝" forState:UIControlStateNormal];
    [btn7.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn7.layer setBorderWidth:1];
    [btn7 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn7 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    UIButton* btn8 = [[UIButton alloc]initWithFrame:CGRectMake(10, 310, f.size.width-20, 30)];
    [btn8 addTarget:self action:@selector(expWXPro:) forControlEvents:UIControlEventTouchUpInside];
    [btn8 setTitle:@"提现进度-微信" forState:UIControlStateNormal];
    [btn8.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn8.layer setBorderWidth:1];
    [btn8 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn8 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    UIButton* btn9 = [[UIButton alloc]initWithFrame:CGRectMake(10, 350, f.size.width-20, 30)];
    [btn9 addTarget:self action:@selector(expAliPro:) forControlEvents:UIControlEventTouchUpInside];
    [btn9 setTitle:@"提现进度-支付宝" forState:UIControlStateNormal];
    [btn9.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn9.layer setBorderWidth:1];
    [btn9 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn9 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    UIButton* btn10 = [[UIButton alloc]initWithFrame:CGRectMake(10, 390, f.size.width-20, 30)];
    [btn10 addTarget:self action:@selector(expWX:) forControlEvents:UIControlEventTouchUpInside];
    [btn10 setTitle:@"提现-微信" forState:UIControlStateNormal];
    [btn10.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn10.layer setBorderWidth:1];
    [btn10 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn10 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    UIButton* btn11 = [[UIButton alloc]initWithFrame:CGRectMake(10, 430, f.size.width-20, 30)];
    [btn11 addTarget:self action:@selector(expAli:) forControlEvents:UIControlEventTouchUpInside];
    [btn11 setTitle:@"提现-支付宝" forState:UIControlStateNormal];
    [btn11.layer setBorderColor:[UIColor blackColor].CGColor];
    [btn11.layer setBorderWidth:1];
    [btn11 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn11 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
//    showLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, f.size.width-20, 100)];
//    showLab.backgroundColor = [UIColor blueColor];
//    showLab.numberOfLines = 0;
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:btn1];
    [scrollView addSubview:btn2];
    [scrollView addSubview:btn3];
    [scrollView addSubview:btn4];
    [scrollView addSubview:btn5];
    [scrollView addSubview:btn6];
    [scrollView addSubview:btn7];
    [scrollView addSubview:btn8];
    [scrollView addSubview:btn9];
    [scrollView addSubview:btn10];
    [scrollView addSubview:btn11];
    

    payKit = [PalmParkPayKit kitWithUser:@"ff808081529a746801529a996bed0000" password:@"e10adc3949ba59abbe56e057f20f883e"];
    payKit.delegate = self;
//    [[PalmParkAPI defaultAPI] setServerHost:@"rtti.f3322.net"];
    //提现申请
    expKit = [PalmParkExpKit kitWithUser:@"ff808081529a746801529a996bed0000" password:@"e10adc3949ba59abbe56e057f20f883e"];
    expKit.delegate = self;
//    [expKit asyncLoadHisUsersOfWX];
//    [expKit asyncQueryscheduleOfAliExportCash];
//    [expKit asyncQueryscheduleOfWXExportCash];
//    OrderEntity *entity = [[OrderEntity alloc]init];
//    entity.price = 100;
//    entity.title = @"测试提现";
//    entity.detail = @"测试提现是否能走通";
//    entity.tradeNo = @"test0001";
//    [expKit setDebitInfo:entity];
//    [expKit asyncExportCashToALI:[AliExpEntity entityWithUserId:@"zhangsan@126.com" name:@"赵四"]];
//    [payKit asyncPayListsOfAli];
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [payKit disappear];
    [expKit disappear];
}
/**
 *  支付宝支付未完成订单
 *
 *  @param sender <#sender description#>
 */
-(void)aliPayList:(UIButton*)sender{
    [payKit asyncPayListsOfAli];
}
/**
 *  微信支付未完成订单
 *
 *  @param sender <#sender description#>
 */
-(void)wxPayList:(UIButton*)sender{
    [payKit asyncPayListsOfWX];
}
/**
 *  支付宝支付
 *
 *  @param sender <#sender description#>
 */
-(void)aliPay:(UIButton*)sender{
    OrderEntity *entity = [[OrderEntity alloc]init];
    entity.price = 1;
    entity.title = @"支付宝测试支付11";
    entity.detail = @"测试支付11";
    entity.tradeNo = @"ali0001";
    [payKit setOrder:entity];
    [payKit aliPay];
}
/**
 *  微信支付
 *
 *  @param sender <#sender description#>
 */
-(void)wxPay:(UIButton*)sender{
    OrderEntity *entity = [[OrderEntity alloc]init];
    entity.price = 1;
    entity.title = @"微信测试支付11";
    entity.detail = @"测试支付环节是否能走通11";
    entity.tradeNo = @"wx0001";
    [payKit setOrder:entity];
    [payKit wxPay];
}
/**
 *  微信授权
 *
 *  @param sender <#sender description#>
 */
-(void)authorWX:(UIButton*)sender{
    [expKit asyncAuthorWX];
}
/**
 *  微信提现历史用户
 *
 *  @param sender <#sender description#>
 */
-(void)expHisWX:(UIButton*)sender{
    [expKit asyncLoadHisUsersOfWX];
}
/**
 *  支付宝提现历史用户
 *
 *  @param sender <#sender description#>
 */
-(void)expHisAli:(UIButton*)sender{
    [expKit asyncLoadHisUsersOfAli];
}
/**
 *  微信提现订单
 *
 *  @param sender <#sender description#>
 */
-(void)expWXPro:(UIButton*)sender{
    [expKit asyncQueryscheduleOfWXExportCash];
}
/**
 *  支付宝提现订单
 *
 *  @param sender <#sender description#>
 */
-(void)expAliPro:(UIButton*)sender{
    [expKit asyncQueryscheduleOfAliExportCash];
}
/**
 *  微信提现
 *
 *  @param sender <#sender description#>
 */
-(void)expWX:(UIButton*)sender{
//        OrderEntity *entity = [[OrderEntity alloc]init];
//        entity.price = 101;
//        entity.title = @"微信测试提现";
//        entity.detail = @"测试提现是否能走通";
//        entity.tradeNo = @"test0001";
//        [expKit setDebitInfo:entity];
    //需要传入微信授权用户的信息
////    [expKit asyncExportCashToWX:<#(WXExpEntity *)#>];
}
/**
 *  支付宝提现
 *
 *  @param sender <#sender description#>
 */
-(void)expAli:(UIButton*)sender{
        OrderEntity *entity = [[OrderEntity alloc]init];
        entity.price = 2;
        entity.title = @"支付宝提现2分钱";
        entity.detail = @"支付宝提现2分钱！";
        entity.tradeNo = @"test00012";
        [expKit setDebitInfo:entity];
    [expKit asyncExportCashToALI:[AliExpEntity entityWithUserId:@"zhangsan@127.com" name:@"赵四"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)payKit:(PalmParkPayKit *)sender createPayList:(NSObject *)order status:(NSInteger)code msg:(NSString *)msg{
     NSLog(@"createPayList onSuccess:%li,%@",(long)code,msg);
}
-(void)payKit:(PalmParkPayKit *)sender payStatus:(NSInteger)code msg:(NSString *)msg{
     NSLog(@"payStatus onSuccess:%li,%@",(long)code,msg);
}
-(void)payKit:(PalmParkPayKit *)sender scheduleOfPayLists:(NSArray *)orders status:(NSInteger)code msg:(NSString *)msg{
     NSLog(@"scheduleOfPayLists onSuccess:%li,%@",(long)code,msg);
    if (orders.count>0) {
        //因为返回值会有多种类型，所以需要区分类型
        if ([orders.firstObject isKindOfClass:[WXPayEntity class]]) {
            [payKit wxPay:(WXPayEntity*)orders.firstObject];
        }else if ([orders.firstObject isKindOfClass:[AliPayEntity class]]) {
            [payKit aliPay:(AliPayEntity*)orders.firstObject];
        }
    }
}
-(void)expKit:(PalmParkExpKit *)kit authorHisUsers:(NSArray *)users{
     NSLog(@"authorHisUsers onSuccess:%@",users);
    if (users.count<1) {
        return;
    }
    //因为返回值会有多种类型，所以需要区分类型
    if ([users[0] isKindOfClass:[WXExpEntity class]]) {
        OrderEntity *entity = [[OrderEntity alloc]init];
        entity.price = 1;
        entity.title = @"测试提现1分钱";
        entity.detail = @"测试提现1";
        entity.tradeNo = @"test0001";
        [expKit setDebitInfo:entity];
        [expKit asyncExportCashToWX:(WXExpEntity*)users[0]];
    }else if ([users[0] isKindOfClass:[AliExpEntity class]]) {
        OrderEntity *entity = [[OrderEntity alloc]init];
        entity.price = 1;
        entity.title = @"测试提现1分钱";
        entity.detail = @"测试提现2";
        entity.tradeNo = @"test0001";
        [expKit setDebitInfo:entity];
        [expKit asyncExportCashToALI:(AliExpEntity*)users[0]];
    }
}
-(void)expKit:(PalmParkExpKit *)kit authorUser:(NSObject *)user status:(NSInteger)code msg:(NSString *)msg{
     NSLog(@"authorUser onSuccess:%li,%@",(long)code,msg);
}
-(void)expKit:(PalmParkExpKit *)kit expStatus:(NSInteger)code msg:(NSString *)msg{
     NSLog(@"expStatus onSuccess:%li,%@",(long)code,msg);
}
-(void)expKit:(PalmParkExpKit *)kit scheduleOfExpLists:(NSArray *)orders status:(NSInteger)code msg:(NSString *)msg{
     NSLog(@"scheduleOfExpLists onSuccess:%li,%@",(long)code,msg);
}
@end
