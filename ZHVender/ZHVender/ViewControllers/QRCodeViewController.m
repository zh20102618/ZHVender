//
//  QRCodeViewController.m
//  ZHVender
//
//  Created by 张晗 on 16/3/9.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "QRCodeViewController.h"

#import "ZHQRCodeView.h"

@interface QRCodeViewController()<ZHQRCodeViewResuleDelegate>

@property (nonatomic, strong) ZHQRCodeView *codeView;

@end

@implementation QRCodeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.navigationItem.title = @"二维码扫描";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.codeView = [[ZHQRCodeView alloc] initWithFrame:self.view.bounds];
    
    self.codeView.delegate = self;
    
    [self.view addSubview:self.codeView];
}

#pragma mark - ZHQRCodeViewResuleDelegate
- (void)zhQRCodeViewDidReceivedResult:(NSString *)result{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:result delegate:nil cancelButtonTitle:@"好" otherButtonTitles: nil];
    
    [alertView show];
    
    NSLog(@"%@",result);
}

- (void)zhQRCodeViewDidReceivedError:(NSError *)error{
    
    NSLog(@"--->出错了<---");
}

@end
