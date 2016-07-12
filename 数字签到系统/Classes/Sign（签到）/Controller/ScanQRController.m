//
//  ScanQRController.m
//  数字签到系统
//
//  Created by VOREVER on 16/5/5.
//  Copyright © 2016年 VOREVER. All rights reserved.
//

#import "ScanQRController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanQRController ()

@property (nonatomic, strong) UIView *scanRectView;
// 硬件设备
@property (strong, nonatomic) AVCaptureDevice            *device;
//输入设备
@property (strong, nonatomic) AVCaptureDeviceInput       *input;
//输出设备
@property (strong, nonatomic) AVCaptureMetadataOutput    *output;
//桥梁.连接输入和输出设备,
@property (strong, nonatomic) AVCaptureSession           *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@end

@implementation ScanQRController

- (void)viewDidLoad {
    self.navigationItem.title = @"扫描二维码";
    [super viewDidLoad];
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    
    CGSize scanSize = CGSizeMake(windowSize.width*3/4, windowSize.width*3/4);
    CGRect scanRect = CGRectMake((windowSize.width-scanSize.width)/2, (windowSize.height-scanSize.height)/2 - 88, scanSize.width, scanSize.height);
    
    scanRect = CGRectMake(scanRect.origin.y/windowSize.height, scanRect.origin.x/windowSize.width, scanRect.size.height/windowSize.height,scanRect.size.width/windowSize.width);
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:([UIScreen mainScreen].bounds.size.height<500)?AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh];
    [self.session addInput:self.input];
    [self.session addOutput:self.output];
    self.output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode];
    self.output.rectOfInterest = scanRect;
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = [UIScreen mainScreen].bounds;
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    self.scanRectView = [UIView new];
    [self.view addSubview:self.scanRectView];
    self.scanRectView.frame = CGRectMake(0, 0, scanSize.width, scanSize.height);
    self.scanRectView.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds) - 88);
    self.scanRectView.layer.borderColor = [UIColor redColor].CGColor;
    self.scanRectView.layer.borderWidth = 1;
    
    
    //开始捕获
    [self.session startRunning];
    
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ( (metadataObjects.count==0) )
    {
        return;
    }
    
    if (metadataObjects.count>0) {
        
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        //输出扫描字符串
        NSLog(@"%@", metadataObject.stringValue);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"课程：现代网络原理\n讲师：高老师" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: @"确认签到", nil];
        
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"确认签到");
        // 回到上一层控制器
        [self.navigationController popViewControllerAnimated:YES];
        if ([self.delegate respondsToSelector:@selector(scanQRDidSign:)]) {
            [self.delegate scanQRDidSign:self];
        }
    } else {
        [self.session startRunning];
    }
}


@end
