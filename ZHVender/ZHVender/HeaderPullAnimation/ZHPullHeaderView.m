//
//  ZHPullHeaderView.m
//  ZHVender
//
//  Created by 张晗 on 16/3/7.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "ZHPullHeaderView.h"

#import "ZHHeaderAnimationFile.h"

@interface ZHPullHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZHPullHeaderView

+ (instancetype)headerViewUsingImage:(UIImage *)image{
    
    ZHPullHeaderView *header = [[self alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ZHHeaderViewHeight)];
    
    header.imageView = [[UIImageView alloc] initWithFrame:header.bounds];
    
    header.imageView.image = image;
    
    header.imageView.contentMode = UIViewContentModeScaleToFill;
    
    [header addSubview:header.imageView];
    
    return header;
}

- (void)animationChangeHeight:(CGFloat)changeHeight{
    
    CGRect rect = self.imageView.frame;
    
    rect.size.height = -changeHeight > ZHMaxPullContentOffsetHeight ? ZHHeaderViewHeight + ZHMaxPullContentOffsetHeight : ZHHeaderViewHeight - changeHeight;
    
    self.imageView.frame = CGRectMake(0, changeHeight, rect.size.width, rect.size.height);
}

@end
