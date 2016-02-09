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
    self.navigationItem.title = @"课程签到";
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
