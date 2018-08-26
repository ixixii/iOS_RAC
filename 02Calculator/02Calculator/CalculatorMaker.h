//
//  CalculatorMaker.h
//  02Calculator
//
//  Created by beyond on 2017/12/10.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorMaker : NSObject
@property (nonatomic,assign) int result;
// 加法:返回block (block的返回值是CalculatorMaker自身,参数是参与运算的值)
- (CalculatorMaker * (^)(int num))add;


// 乘法:返回block (block的返回值是CalculatorMaker自身,参数是参与运算的值)
- (CalculatorMaker * (^)(int num))multiply;
@end
