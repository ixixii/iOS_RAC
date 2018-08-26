//
//  ViewController.m
//  04函数式编程
//
//  Created by beyond on 2017/12/11.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Calculator *calc = [[Calculator alloc]init];
    
    /*
     函数式编程:把操作尽量写成一系列嵌套的函数或方法调用.
     特点:1.每个方法(如下面的add方法)必须有返回值(本身对象),
     2.把函数或者block当成参数.
     3.block的参数是需要操作的成员变量
     4.block的返回值是操作完成后的结果
     */
    int output = [[calc add:^int(int result) {
        result += 1;
        result += 20;
        // 返回block操作完成后的值(目的是用于保存到成员变量里)
        return result;
    }] result];
    NSLog(@"sg_%d",output);
}




@end
