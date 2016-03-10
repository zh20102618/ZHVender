//
//  ZHQRCodeView.h
//  ZHVender
//
//  Created by 张晗 on 16/3/9.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHQRCodeViewResuleDelegate <NSObject>

/** 获取到扫描结果 */
- (void)zhQRCodeViewDidReceivedResult:(NSString *)result;

/** 扫描遇到错误 */
- (void)zhQRCodeViewDidReceivedError:(NSError *)error;

@end

@interface ZHQRCodeView : UIView

@property (nonatomic, weak) id<ZHQRCodeViewResuleDelegate>delegate;

/** 开始扫描*/
- (void)startScan;

/** 停止扫描*/
- (void)stopScan;

/** 开始动画*/
- (void)startAnimating;

/** 停止动画*/
- (void)stopAnimating;

@end

