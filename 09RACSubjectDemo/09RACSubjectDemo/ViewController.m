//
//  ViewController.m
//  09RACSubjectDemo
//
//  Created by beyond on 2017/12/26.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 订阅信号
    [_redView.btnClickSignal subscribeNext:^(id  _Nullable newValue) {
        NSLog(@"sg_%@",newValue);
    }];
}

@end
