//
//  ViewController.m
//  01mansonry
//
//  Created by beyond on 2017/12/8.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
// 拖入Masonry文件夹
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    [self.view addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@10);
        make.right.bottom.equalTo(@-20);
    }];
}




@end
