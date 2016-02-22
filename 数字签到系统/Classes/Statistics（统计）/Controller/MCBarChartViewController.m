//
//  MCBarChartViewController.m
//  MCChartView
//
//  Created by zhmch0329 on 15/8/17.
//  Copyright (c) 2015年 zhmch0329. All rights reserved.
//

#import "MCBarChartViewController.h"
#import "MCBarChartView.h"

@interface MCBarChartViewController () <MCBarChartViewDataSource, MCBarChartViewDelegate>

@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) MCBarChartView *barChartView;

@end

@implementation MCBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 将状态栏设置为白色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: [UIColor whiteColor],
        NSFontAttributeName : [UIFont boldSystemFontOfSize:18]
    };
    self.navigationItem.title = @"考勤统计";
    [self.view setBackgroundColor:[UIColor colorWithRed:235/255.0 green:239/255.0 blue:241/255.0 alpha:1.0]];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _titles = @[@"语文", @"数学", @"英语", @"物理", @"化学", @"生物"];
    _dataSource = [NSMutableArray arrayWithArray:@[@100, @80, @90, @100, @100, @90]];

    _barChartView = [[MCBarChartView alloc] initWithFrame:CGRectMake(10, 20, [UIScreen mainScreen].bounds.size.width - 20, 280)];
    _barChartView.tag = 111;
    _barChartView.dataSource = self;
    _barChartView.delegate = self;
    _barChartView.maxValue = @100;
    _barChartView.unitOfYAxis = @"％";
    _barChartView.colorOfXAxis = [UIColor darkGrayColor];
    _barChartView.colorOfXText = [UIColor darkGrayColor];
    _barChartView.colorOfYAxis = [UIColor darkGrayColor];
    _barChartView.colorOfYText = [UIColor darkGrayColor];
    [self.view addSubview:_barChartView];
    

}

- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView {
    return [_dataSource count];
}

- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section {
    return 1;
}

- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index {
    return _dataSource[section];
}

- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index {
    return [UIColor colorWithRed:25/255.0 green:187/255.0 blue:155/255.0 alpha:1.0];
}

- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section {
    return _titles[section];
}

- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView {
    return 26;
}

- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView {
    return 20;
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com