//
//  SignTableViewCell.m
//  数字签到系统
//
//  Created by VOREVER on 2/5/16.
//  Copyright © 2016 VOREVER. All rights reserved.
//

#import "SignTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface SignTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *CourseName;
@property (weak, nonatomic) IBOutlet UILabel *CourseTeacher;
@property (weak, nonatomic) IBOutlet UIButton *SignBtn;

@end

@implementation SignTableViewCell

- (IBAction)clickSignBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(CellButtonClick:Button:)]) {
        [self.delegate CellButtonClick:self Button:sender];
    }
}

- (void)changeSignButtonStatus:(BOOL)status{
    self.SignBtn.enabled = status;
    [self.SignBtn setTitle:@"已签到" forState:UIControlStateDisabled];
}

@end
