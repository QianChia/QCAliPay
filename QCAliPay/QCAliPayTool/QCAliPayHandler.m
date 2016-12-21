//
//  QCAliPayHandler.m
//  QCAliPay
//
//  Created by JHQ0228 on 2016/12/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

/**
 *  支付宝支付调用工具类
 */

#import "QCAliPayHandler.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
    #import <AFNetworking/AFNetworking.h>
    #import <AFNetworkActivityIndicatorManager.h>
#else
    #import "AFNetworking.h"
    #import "AFNetworkActivityIndicatorManager.h"
#endif

@implementation QCAliPayHandler

#pragma mark - Public Methods

/// 发起支付宝商户服务器端签名支付
+ (void)QCAliPay_SER {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 在此设置商户服务端需要的参数
    params[@"totalFee"] = @"10";
    params[@"bodyID"] = @"1";
    
    // 向商户支付宝支付服务器端请求组装和签名后的请求串 orderString
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];

    [sessionManager POST:QCUrlUserAliPay
              parameters:params
                progress:nil
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
        // 解析商户支付宝支付服务器端返回的数据，获得组装和签名后的请求串 orderString
        
        NSLog(@"responseObject = %@", responseObject);
         
        NSString *orderString = responseObject[@"signedString"];
         
        if (orderString != nil) {
             
             // 应用注册的 scheme，在 Info.plist 定义 URL types
             NSString *appScheme = QCURLScheme;
             
             // 调用支付结果开始支付
             [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                 
                 NSLog(@"reslut = %@", resultDic);
             }];
        }
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         NSLog(@"向商户支付宝支付服务器端请求信息失败：%@", error.localizedDescription);
    }];
}

/// 发起支付宝 APP 端签名支付
+ (void)QCAliPay_APP {
    
    // AppId 和 PrivateKey 没有配置下的提示
    if (  [QCAlipayAPPID length] == 0
        ||[QCAlipayPrivateKey length] == 0
        ||[QCAlipayAPPID isEqualToString:@"请配置你的 AppID"]
        ||[QCAlipayPrivateKey isEqualToString:@"请配置你的支付宝 pkcs8 私钥"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少 appId 或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    // 商品价格
    NSString *price = [NSString stringWithFormat:@"%.2f", 0.01];
    
    // 将商品信息赋予 AlixPayOrder 的成员变量
    Order *order    = [Order new];
    order.app_id    = QCAlipayAPPID;                                // app_id 设置
    order.method    = QCUrlAlipay;                                  // 支付接口名称
    order.charset = @"utf-8";                                       // 参数编码格式
    
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];     // 当前时间点
    
    order.version   = @"1.0";                                       // 支付版本
    order.sign_type = @"RSA";                                       // sign_type 设置
    
    // NOTE: 商品数据
    order.biz_content                   = [BizContent new];
    order.biz_content.body              = @"我是测试数据";
    order.biz_content.subject           = @"1";
    order.biz_content.out_trade_no      = [self generateTradeNO];   // 订单 ID（由商家自行制定）
    order.biz_content.timeout_express   = @"30m";                   // 超时时间设置
    order.biz_content.total_amount      = price;                    // 商品价格
    
    // 将商品信息拼接成字符串
    NSString *orderInfo         = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded  = [order orderInfoEncoded:YES];
    
    NSLog(@"orderSpec = %@",orderInfo);
    
    // 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    // 需要遵循 RSA 签名规范，并将签名字符串 base64 编码和 UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(QCAlipayPrivateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // 如果加签成功，则继续执行支付
    if (signedString != nil) {
        
        // 应用注册 scheme，在 Info.plist 定义 URL types
        NSString *appScheme = QCURLScheme;
        
        // 将签名成功字符串格式化为订单字符串，请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@", orderInfoEncoded, signedString];
        
        // 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@", resultDic);
        }];
    }
}

#pragma mark - Private Method

/// 产生随机字符串
+ (NSString *)generateTradeNO {
    
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}

@end
