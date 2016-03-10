//
//  ZHQRCodeView.m
//  ZHVender
//
//  Created by 张晗 on 16/3/9.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "ZHQRCodeView.h"

#import <AVFoundation/AVFoundation.h>

#define MainHeight ([UIScreen mainScreen].bounds.size.height)

#define MainWidth ([UIScreen mainScreen].bounds.size.width)

#define AreaScale (MainWidth/320)

#define LengthOfSide 200

@interface ZHQRCodeView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, strong) UIImageView *animteLine;

@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, assign) BOOL isAtTop;

@end

@implementation ZHQRCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self prepareForLoading];
    }
    return self;
}

- (void)prepareForLoading{
    
    /* 设置扫描区域的背景框 */
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((MainWidth - LengthOfSide * AreaScale)/2, 0, LengthOfSide, LengthOfSide)];
    
    imageView.image = [UIImage imageNamed:@"scanBG"];
    
    imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    imageView.contentMode = UIViewContentModeScaleToFill;
    
    [self addSubview:imageView];
    
    self.animteLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), 5)];
    
    self.animteLine.image = [UIImage imageNamed:@"scanLine"];
    
    self.animteLine.contentMode = UIViewContentModeScaleToFill;
    
    [imageView addSubview:self.animteLine];
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    /* 设置高质量的采集率 */
    [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    /* 获取摄像设备 */
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    /* 创建输入流 */
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    if (input) {
        
        [self.captureSession addInput:input];
    }
    
    /* 创建输出流 */
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    output.rectOfInterest = [self calculateVaildAreaWithBGFrame:imageView.frame];
    
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if (output) {
        
        [self.captureSession addOutput:output];
        
        /* 设置扫描支持的格式 */
        NSMutableArray *typeArr = [NSMutableArray array];
        
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            
            [typeArr addObject:AVMetadataObjectTypeQRCode];
        }
        
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            
            [typeArr addObject:AVMetadataObjectTypeEAN13Code];
        }
        
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            
            [typeArr addObject:AVMetadataObjectTypeEAN8Code];
        }
        
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            
            [typeArr addObject:AVMetadataObjectTypeCode128Code];
        }
        
        output.metadataObjectTypes = typeArr;
    }
    
    /* 添加摄像到视图上面 */
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    layer.frame = self.layer.bounds;
    
    [self.layer insertSublayer:layer below:imageView.layer];
    
    [self startScan];
}

/**
 *  有效的扫描区域
 */
- (CGRect)calculateVaildAreaWithBGFrame:(CGRect)bgRect{
    
    CGFloat x, y, width, height = 0;
    
    y = (MainWidth - LengthOfSide * AreaScale)/2 / CGRectGetWidth(self.bounds);
    
    x = (MainHeight - LengthOfSide * AreaScale)/2 / CGRectGetHeight(self.bounds);
    
    height = LengthOfSide * AreaScale / CGRectGetWidth(self.bounds);
    
    width = LengthOfSide * AreaScale / CGRectGetHeight(self.bounds);
    
    return CGRectMake(x, y, width, height);
}

- (void)startScan{

    [self.captureSession startRunning];
    
    [self startAnimating];
}

- (void)stopScan{
    
    [self.captureSession stopRunning];
    
    [self stopAnimating];
}

- (void)startAnimating{
    
    self.isAnimating = YES;
    
    [self animatingCircle];
}

- (void)animatingCircle{
    
    if (self.isAnimating) {
        
        [UIView animateWithDuration:2 animations:^{
            
            CGRect rect = self.animteLine.frame;
            
            if (self.isAtTop) {
                
                rect.origin.y = LengthOfSide - rect.size.height;
                
            }else{
                
                rect.origin.y = 0;
            }
            
            self.animteLine.frame = rect;
            
            self.isAtTop = !self.isAtTop;
            
        } completion:^(BOOL finished) {
            
            [self animatingCircle];
        }];
    }
}

- (void)stopAnimating{
    
    self.isAnimating = NO;
}

#pragma AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    [self stopScan];
    
    if (metadataObjects.count > 0) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(zhQRCodeViewDidReceivedResult:)]) {
            
            AVMetadataMachineReadableCodeObject *result = metadataObjects.firstObject;
            
            [self.delegate zhQRCodeViewDidReceivedResult:result.stringValue];
        }
        
    }else{
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(zhQRCodeViewDidReceivedError:)]) {
            
            [self.delegate zhQRCodeViewDidReceivedError:nil];
        }
    }
}

@end
