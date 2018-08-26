//
//  CalculatorMaker.m
//  02Calculator
//
//  Created by beyond on 2017/12/10.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "CalculatorMaker.h"

@implementation CalculatorMaker
// 返回block (block的返回值是CalculatorMaker自身,参数是参与运算的值)
- (CalculatorMaker * (^)(int num))add
{
    return ^(int num){
        // 参与运算后,保存在成员变量_result内
        _result += num;
        return self;
    };
}



// 返回block (block的返回值是CalculatorMaker自身,参数是参与运算的值)
- (CalculatorMaker *(^)(int num))multiply
{
    return ^(int num){
        // 参与运算后,保存在成员变量_result内
        _result *= num;
        return self;
    };
}
@end
