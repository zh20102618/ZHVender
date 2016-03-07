//
//  UITableView+SpringAnimation.m
//  ZHVender
//
//  Created by 张晗 on 16/3/7.
//  Copyright © 2016年 kuangxiang. All rights reserved.
//

#import "UITableView+SpringAnimation.h"

#import <objc/runtime.h>

NSString *ZHPullHeaderViewKey = @"ZHPullHeaderViewKey";

@implementation UITableView (SpringAnimation)

- (ZHPullHeaderView *)pullHeaderView{
    
    return objc_getAssociatedObject(self, &ZHPullHeaderViewKey);
}

- (void)setPullHeaderView:(ZHPullHeaderView *)pullHeaderView{
    
    if (pullHeaderView != self.pullHeaderView) {
        
        [self willChangeValueForKey:@"pullHeaderView"];
        
        objc_setAssociatedObject(self, &ZHPullHeaderViewKey, pullHeaderView, OBJC_ASSOCIATION_ASSIGN);
        
        [self didChangeValueForKey:@"pullHeaderView"];
    }
}

@end
