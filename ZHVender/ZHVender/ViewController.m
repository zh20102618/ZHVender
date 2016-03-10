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

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *vcArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.dataArray = @[@"二维码扫描"];
    
    self.vcArray = @[@"QRCodeViewController"];
    
    self.tableView.pullHeaderView = [ZHPullHeaderView headerViewUsingImage:[UIImage imageNamed:@"Image2"]];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RootCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootCell"];
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class C = NSClassFromString([self.vcArray objectAtIndex:indexPath.row]);
    
    id ctl = [[C alloc] init];
    
    [self.navigationController pushViewController:ctl animated:YES];
}

@end
