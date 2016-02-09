//
//  PersonalViewController.m
//  数字签到系统
//
//  Created by VOREVER on 2/4/16.
//  Copyright © 2016 XiongSiYao. All rights reserved.
//

#import "PersonalViewController.h"
#import "AFNetworking.h"
#import "User.h"
#import "MBProgressHUD+MJ.h"
#import "NSString+Hash.h"

#define vMargin 20

@interface PersonalViewController ()

@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) NSDictionary *userDict;
@property (nonatomic, strong) User *user;



@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    [self setLoginPage];
}

/*
 * 设置登陆页面
 */
- (void)setLoginPage {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenW = screenRect.size.width;
    
    // 用户名输入框
    CGFloat userNameX = vMargin;
    CGFloat userNameY = vMargin;
    CGFloat userNameW = screenW - 2 * vMargin;
    CGFloat userNameH = 2 * vMargin;
    self.userName = [[UITextField alloc] initWithFrame:CGRectMake(userNameX, userNameY, userNameW, userNameH)];
    self.userName.placeholder = @"请输入用户名";
    [self.userName setBorderStyle:UITextBorderStyleRoundedRect];
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.userName];
    
    // 密码输入框
    CGFloat passwordX = vMargin;
    CGFloat passwordY = userNameY + userNameH + vMargin;
    CGFloat passwordW = screenW - 2 * vMargin;
    CGFloat passwordH = 2 * vMargin;
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(passwordX, passwordY, passwordW, passwordH)];
    self.password.placeholder = @"请输入密码";
    self.password.secureTextEntry = YES;
    [self.password setBorderStyle:UITextBorderStyleRoundedRect];
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.password];
    
    // 登录按钮
    CGFloat loginBtnX = vMargin;
    CGFloat loginBtnY = passwordY + passwordH + vMargin;
    CGFloat loginBtnW = screenW - 2 * vMargin;
    CGFloat loginBtnH = 2 * vMargin;
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH)];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:50/255.0 green:220/255.0 blue:181/255.0 alpha:1.0]];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    // 设置按钮圆角
    loginBtn.layer.cornerRadius = 5.0;
    [loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

/*
 * 登录按钮的监听事件
 */
- (void)clickLoginBtn:(UIButton *)sender {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = @"正在拼命登录中。。。";
    [hud show:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = [NSString stringWithFormat:@"\'%@\'",self.userName.text];
    params[@"password"] = [self.password.text md5String];
    params[@"format"] = @"json";
    
    NSString *url = @"http://192.168.0.104/45min/login.php";
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _userDict = responseObject;
        [hud hide:YES];
        if ([@"200" isEqualToString:self.userDict[@"code"]]) {
            [self initUser];
            [self setUserPage];
        } else {
            if ([@"402" isEqualToString:self.userDict[@"code"]]) {
                NSLog(@"密码错误");
            } else if ([@"403" isEqualToString:self.userDict[@"code"]]) {
                NSLog(@"无此用户");
            } else if ([@"405" isEqualToString:self.userDict[@"code"]]) {
                NSLog(@"数据库连接失败");
            }
            [self hudForError];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@", error);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/**
 * 初始化用户信息
 */
- (void)initUser {
    _user = [User userWithDict:self.userDict];
    NSLog(@"%@", _user);
}

/**
 * 显示登陆成功信息
 */
- (void)hudForSuccess {
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/success.png"]]];
    hud.labelText = @"登录成功！";
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

/**
 * 显示登陆失败信息
 */
- (void)hudForError {
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/error.png"]]];
    hud.labelText = @"登录失败!";
    [hud show:YES];
    [hud hide:YES afterDelay:1.0];
}

/**
 * 设置个人中心页面
 */
- (void)setUserPage {
    // 移除所有控件
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self hudForSuccess];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenW = screenRect.size.width;
    
    CGFloat userNameX = vMargin;
    CGFloat userNameY = vMargin;
    CGFloat userNameW = screenW - 2 * vMargin;
    CGFloat userNameH = 2 * vMargin;
    UILabel *username = [[UILabel alloc] initWithFrame:CGRectMake(userNameX, userNameY, userNameW, userNameH)];
    username.text = [NSString stringWithFormat:@"用户名：%@", self.user.username];
    [self.view addSubview:username];
    
    CGFloat emailX = vMargin;
    CGFloat emailY = userNameY + userNameH + vMargin;;
    CGFloat emailW = screenW - 2 * vMargin;
    CGFloat emailH = 2 * vMargin;
    UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(emailX, emailY, emailW, emailH)];
    email.text = [NSString stringWithFormat:@"邮箱：%@", self.user.email];
    [self.view addSubview:email];
    
    CGFloat nickNameX = vMargin;
    CGFloat nickNameY = emailY + emailH + vMargin;
    CGFloat nickNameW = screenW - 2 * vMargin;
    CGFloat nickNameH = 2 * vMargin;
    UILabel *nickname = [[UILabel alloc] initWithFrame:CGRectMake(nickNameX, nickNameY, nickNameW, nickNameH)];
    nickname.text = [NSString stringWithFormat:@"昵称：%@", self.user.nickname];
    [self.view addSubview:nickname];
    
    CGFloat numberX = vMargin;
    CGFloat numberY = nickNameY + nickNameH + vMargin;
    CGFloat numberW = screenW - 2 * vMargin;
    CGFloat numberH = 2 * vMargin;
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(numberX, numberY, numberW, numberH)];
    number.text = [NSString stringWithFormat:@"学号：%@", self.user.number];
    [self.view addSubview:number];
    
    CGFloat lastTimeX = vMargin;
    CGFloat lastTimeY = numberY + numberH + vMargin;
    CGFloat lastTimeW = screenW - 2 * vMargin;
    CGFloat lastTimeH = 2 * vMargin;
    UILabel *lastTime = [[UILabel alloc] initWithFrame:CGRectMake(lastTimeX, lastTimeY, lastTimeW, lastTimeH)];
    lastTime.text = [NSString stringWithFormat:@"最后登录时间：%@", self.user.last_time];
    [self.view addSubview:lastTime];

}

@end
