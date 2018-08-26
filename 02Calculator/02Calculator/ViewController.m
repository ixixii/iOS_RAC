//
//  ViewController.m
//  02Calculator
//
//  Created by beyond on 2017/12/10.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Calculator.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建一个分类,使得任何类都可以用类方法,进行计算
    int result = [NSObject makeCalculator:^(CalculatorMaker *maker) {
        maker.add(1).add(20).multiply(3);
    }];
    NSLog(@"sg__%d",result);
}



@end
