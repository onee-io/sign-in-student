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
    // 将状态栏设置为白色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
    };
    self.navigationItem.title = @"课程签到";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    NSLog(@"%s",__func__);
    return UIStatusBarStyleLightContent;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
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
