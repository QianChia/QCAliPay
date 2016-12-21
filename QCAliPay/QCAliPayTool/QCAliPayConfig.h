//
//  QCAliPayConfig.h
//  QCAliPay
//
//  Created by JHQ0228 on 2016/12/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

/**
 *  支付宝支付配置文件
 */

#ifndef QCAliPayConfig_h
#define QCAliPayConfig_h

#import <UIKit/UIKit.h>
#import <AlipaySDK/AlipaySDK.h>

#import "QCAliPayManager.h"         // 支付宝支付结果回调类
#import "QCAliPayHandler.h"         // 支付宝调用工具类
#import "DataSigner.h"              // 支付宝签名类
#import "Order.h"                   // 订单模型

/**
 * -----------------------------------
 *  应用注册 scheme
 * -----------------------------------
 */

// 在 Info.plist 定义 URL types
#define QCURLScheme         @"alisdkdemo"

/**
 * -----------------------------------
 *  商户支付宝支付后台接口
 * -----------------------------------
 */

#define QCUrlUserAliPay     @"test"

/**
 * -----------------------------------
 *  支付宝支付需要配置的参数
 * 
 *  这些参数配置仅作为客户端示例使用。商户实际支付过程中参数需要放置在服务端，且整个签名过程必须在服务端进行。
 * -----------------------------------
 */

// 管理中心获取 APPID
#define QCAlipayAPPID       @"请配置你的 AppID"

// 支付宝私钥（用户自主生成，使用 pkcs8 格式的私钥），实际场景下请商户把私钥保存在服务端，在服务端进行支付请求参数签名。
#define QCAlipayPrivateKey  @"请配置你的支付宝 pkcs8 私钥"

// 支付宝支付接口
#define QCUrlAlipay         @"alipay.trade.app.pay"


#endif /* QCAliPayConfig_h */
