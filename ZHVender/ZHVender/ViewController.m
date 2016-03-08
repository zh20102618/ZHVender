//
//  ViewController.m
//  ZHVender
//
//  Created by 张晗 on 16/3/7.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "ViewController.h"

#import "RootCell.h"

#import "UITableView+SpringAnimation.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.pullHeaderView = [ZHPullHeaderView headerViewUsingImage:[UIImage imageNamed:@"Image2"]];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell"];
    
    cell.textLabel.text = @"数据库";
    
    return cell;
}

@end
