//
//  ScanQRController.h
//  数字签到系统
//
//  Created by VOREVER on 16/5/5.
//  Copyright © 2016年 VOREVER. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanQRController;

@protocol ScanQRControllerDelegate <NSObject>

@optional
- (void)scanQRDidSign:(ScanQRController *)controller;

@end

@interface ScanQRController : UIViewController

@property (nonatomic, weak) id<ScanQRControllerDelegate> delegate;

@end
