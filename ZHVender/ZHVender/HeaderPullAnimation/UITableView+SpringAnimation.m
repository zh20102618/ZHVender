//
//  UITableView+SpringAnimation.m
//  ZHVender
//
//  Created by 张晗 on 16/3/7.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "UITableView+SpringAnimation.h"

#import "ZHHeaderAnimationFile.h"

#import <objc/runtime.h>

@implementation UITableView (SpringAnimation)

- (ZHPullHeaderView *)pullHeaderView{
    
    return objc_getAssociatedObject(self, &ZHPullHeaderViewKey);
}

- (void)setPullHeaderView:(ZHPullHeaderView *)pullHeaderView{
    
    if (pullHeaderView != self.pullHeaderView) {
        
        [self willChangeValueForKey:@"pullHeaderView"];
        
        objc_setAssociatedObject(self, &ZHPullHeaderViewKey, pullHeaderView, OBJC_ASSOCIATION_ASSIGN);
        
        self.tableHeaderView = pullHeaderView;
        
        [self didChangeValueForKey:@"pullHeaderView"];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    
    [super willMoveToSuperview:newSuperview];
    
    if (!newSuperview) {
        
        return;
    }
    
    [self addObserver];
}

- (void)addObserver{

    [self addObserver:self forKeyPath:ZHScrollViewContentOffset options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)removeObserver{
    
    [self removeObserver:self forKeyPath:ZHScrollViewContentOffset];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if (![keyPath isEqualToString:ZHScrollViewContentOffset]) {
        
        return;
    }
    
    CGFloat newOffset = [[change valueForKey:@"new"] CGPointValue].y;
    
    if (newOffset > 0) {
    
    }else if (-newOffset > ZHMaxPullContentOffsetHeight) {
        
        self.contentOffset = [[change valueForKey:@"old"] CGPointValue];
        
    }else{
        
        [self.pullHeaderView animationChangeHeight:newOffset];
    }
}

@end
