//
//  ViewController.m
//  ZHVender
//
//  Created by 张晗 on 16/3/7.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "ViewController.h"

#import "RootCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
