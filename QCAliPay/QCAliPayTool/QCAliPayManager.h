//
//  QCAliPayManager.h
//  QCAliPayDemo
//
//  Created by JHQ0228 on 2016/12/21.
//  Copyright © 2016年 QianQian-Studio. All rights reserved.
//

/**
 *  支付宝支付结果回调类
 */

#import <Foundation/Foundation.h>

@interface QCAliPayManager : NSObject

+ (instancetype)sharedManager;

- (void)paymentResult:(NSURL *)url;

@end
