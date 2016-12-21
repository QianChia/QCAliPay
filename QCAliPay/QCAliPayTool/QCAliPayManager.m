//
//  QCAliPayManager.m
//  QCAliPayDemo
//
//  Created by JHQ0228 on 2016/12/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

/**
 *  支付宝支付结果回调类
 */

#import "QCAliPayManager.h"

@implementation QCAliPayManager

#pragma mark - 单例

+ (instancetype)sharedManager {
    
    static QCAliPayManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)paymentResult:(NSURL *)url {
    
    // 处理支付结果
    if ([url.host isEqualToString:@"safepay"]) {
    
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@", resultDic);
        }];
    }
}

@end
