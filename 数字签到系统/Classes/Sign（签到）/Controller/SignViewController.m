//
//  SignViewController.m
//  数字签到系统
//
//  Created by VOREVER on 2/4/16.
//  Copyright © 2016 XiongSiYao. All rights reserved.
//

#import "SignViewController.h"
#import "SignTableViewCell.h"

@interface SignViewController ()

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSThread sleepForTimeInterval:1.0]; // 启动页延迟一秒
    // 将状态栏设置为白色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
    };
    self.navigationItem.title = @"课程签到";
    [self.view setBackgroundColor:[UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0]];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    NSLog(@"%s",__func__);
    return UIStatusBarStyleLightContent;
}

#pragma mark 分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark 每组显示数据数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

#pragma mark 分组头部信息
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"正在进行课程";
    } else {
        return @"未开始课程";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    SignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SignTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


@end
