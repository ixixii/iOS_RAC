//
//  Calculator.m
//  04函数式编程
//
//  Created by beyond on 2017/12/11.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator
/*
 函数式编程:把操作尽量写成一系列嵌套的函数或方法调用.
 特点:1.每个方法(如下面的add方法)必须有返回值(本身对象),
 2.把函数或者block当成参数.
 3.block的参数是需要操作的成员变量
 4.block的返回值是操作完成后的结果
 */


// add方法:返回值是本身
// add方法:参数是一个block;
// block的参数是外部控制器要操作的成员变量result
// block的返回值是外部控制器操作完成后的结果数值
- (instancetype)add:(int (^)(int result))block
{
    //直接调用外部控制器的block,并且把外部控制器要操作的本类的成员变量传递进去,并且把block的返回值保存在成员变量里
    _result = block(_result);
    
    
    // 返回本身
    return self;
}
@end
