//
//  ViewController.m
//  LHQPullMenuDemo
//
//  Created by WaterWorld on 2019/3/27.
//  Copyright © 2019年 linhuaqin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIView        *headerView;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, assign) BOOL          isShow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)setupUI {
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY = %.2f",offsetY);
    if (self.isShow) {
        // 隐藏
        if (offsetY > 45) {
            self.tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
            self.isShow = NO;
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
            });
        }
    } else {
        // 显示
        if (offsetY < 80) {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.isShow = YES;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
            });
        }
    }
}

#pragma mark - lazy
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
        _headerView.backgroundColor = [UIColor orangeColor];
    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.contentInset = UIEdgeInsetsMake(-100, 0, 0, 0);
        _tableView.tableHeaderView = self.headerView;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        _tableView.rowHeight = 50;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}


@end
