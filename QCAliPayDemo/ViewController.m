//
//  ViewController.m
//  QCAliPayDemo
//
//  Created by JHQ0228 on 2016/12/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)aliPayClick:(UIButton *)sender {
    
    // 发起支付宝支付
    [QCAliPayHandler QCAliPay_SER];
}

@end
