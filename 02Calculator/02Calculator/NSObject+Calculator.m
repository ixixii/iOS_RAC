//
//  NSObject+Calculator.m
//  02Calculator
//
//  Created by beyond on 2017/12/10.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "NSObject+Calculator.h"

@implementation NSObject (Calculator)
+(int)makeCalculator:(void (^)(CalculatorMaker *))block
{
    // 创建一个计算器
    CalculatorMaker *maker = [[CalculatorMaker alloc]init];
    // 将计算器传递给外部 控制器,并且计算器会在内部自动处理result
    block(maker);
    // 返回处理后的结果 
    return maker.result;
}
@end
