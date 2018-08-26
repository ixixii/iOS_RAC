//
//  RedView.m
//  09RACSubjectDemo
//
//  Created by beyond on 2017/12/26.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "RedView.h"

@implementation RedView
// 懒加载
- (RACSubject *)btnClickSignal
{
    if (_btnClickSignal == nil) {
        // 1.创建信号
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}

// 按钮点击
- (void)btnClicked:(UIButton *)sender
{
    // 3.发送信号
    [self.btnClickSignal sendNext:@"newValue"];
    
}
@end
