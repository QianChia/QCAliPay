//
//  QCAliPayHandler.h
//  QCAliPay
//
//  Created by JHQ0228 on 2016/12/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

/**
 *  支付宝支付调用工具类
 */

#import <Foundation/Foundation.h>

@interface QCAliPayHandler : NSObject

/// 发起支付宝 APP 端签名支付
+ (void)QCAliPay_APP;

/// 发起支付宝商户服务器端签名支付
+ (void)QCAliPay_SER;

@end
