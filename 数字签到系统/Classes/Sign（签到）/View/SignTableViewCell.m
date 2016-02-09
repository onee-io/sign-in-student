//
//  SignTableViewCell.m
//  数字签到系统
//
//  Created by VOREVER on 2/5/16.
//  Copyright © 2016 XiongSiYao. All rights reserved.
//

#import "SignTableViewCell.h"

@interface SignTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *CourseName;
@property (weak, nonatomic) IBOutlet UILabel *CourseTeacher;


@end

@implementation SignTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickSignBtn:(UIButton *)sender {
    NSLog(@"%s",__func__);
}

@end
