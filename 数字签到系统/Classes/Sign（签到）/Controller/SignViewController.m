//
//  SignViewController.m
//  数字签到系统
//
//  Created by VOREVER on 2/4/16.
//  Copyright © 2016 VOREVER. All rights reserved.
//

#import "SignViewController.h"
#import "SignTableViewCell.h"
#import "FMDB.h"
#import "MBProgressHUD+MJ.h"
#import "ScanQRController.h"

@interface SignViewController () <SignTableViewCellDelegate, ScanQRControllerDelegate>

@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) SignTableViewCell *clickCell;


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
    
    [self initDataBase];
//    if (![self checkUser]) {
//        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
//        [self.view addSubview:hud];
//        hud.removeFromSuperViewOnHide = YES;
//        hud.mode = MBProgressHUDModeCustomView;
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/error.png"]]];
//        hud.labelText = @"请先登录账户";
//        [hud show:YES];
//        [hud hide:YES afterDelay:1.0];
//    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = item;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    NSLog(@"%s",__func__);
    return UIStatusBarStyleLightContent;
}

#pragma mark 初始化数据库
- (void)initDataBase {
    
    if ([self.db open]) {
        NSLog(@"数据库打开成功");
        if (![self isTableOK:@"t_user"]) {
            // 创建用户信息表
            NSString *sql = @"CREATE TABLE `t_user` (`realname` varchar(100) NOT NULL,`number` varchar(100) NOT NULL,`password` varchar(100) NOT NULL,`last_time` varchar(100) NOT NULL,`sex` varchar(100) NOT NULL,`department` varchar(100) NOT NULL,`major` varchar(100) NOT NULL,`grade` varchar(100) NOT NULL,`class` varchar(100) NOT NULL,PRIMARY KEY (`number`));";
            if ([self.db executeUpdate:sql]) {
                NSLog(@"创建user表成功");
            } else {
                NSLog(@"创建user表失败");
            }
        }
    } else {
        NSLog(@"数据库打开失败");
    }
}

#pragma mark 检查数据库中是否有登录用户
- (BOOL)checkUser {
    NSString *sql = @"SELECT * FROM 't_user'";
    FMResultSet *result = [self.db executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
}

- (FMDatabase *)db {
    if (_db == nil) {
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *filePath = [cachePath stringByAppendingPathComponent:@"user.sqlite"];
        _db = [FMDatabase databaseWithPath:filePath];
    }
    return _db;
}

#pragma mark 判断sqlite数据库中是否存在一张表
- (BOOL) isTableOK:(NSString *)tableName
{
    FMResultSet *rs = [self.db executeQuery:@"select count(*) as 'count' from sqlite_master where type ='table' and name = ?", tableName];
    while ([rs next])
    {
        NSInteger count = [rs intForColumn:@"count"];
        if (0 == count) {
            return NO;
        } else {
            return YES;
        }
    }
    return NO;
}

#pragma mark 判断某张表中是否存在某一条数据
- (BOOL)isExistDataForColumn:(NSString *)column Value:(NSString *)value TableName:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE %@ = '%@'", tableName, column, value];
    FMResultSet *result = [self.db executeQuery:sql];
    while ([result next]) {
        return YES;
    }
    return NO;
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
//    cell.delegate = self;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SignTableViewCell" owner:nil options:nil] lastObject];
        cell.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (void)CellButtonClick:(SignTableViewCell *)signTableViewCell Button:(UIButton *)sender{
    NSLog(@"在主界面中监听到点击事件");
    if (![self checkUser]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        [self.view addSubview:hud];
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/error.png"]]];
        hud.labelText = @"请先登录账户";
        [hud show:YES];
        [hud hide:YES afterDelay:1.0];
        return;
    }
    self.clickCell = signTableViewCell;
    ScanQRController *controller = [[ScanQRController alloc] init];
    controller.delegate = self;
    [self.navigationController  pushViewController:controller animated:YES];
    
}

- (void)scanQRDidSign:(ScanQRController *)controller{
    NSLog(@"主界面中完成签到");
    [self.clickCell changeSignButtonStatus:NO];
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/success.png"]]];
    hud.labelText = @"签到成功";
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}


@end
