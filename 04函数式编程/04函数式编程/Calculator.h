//
//  Calculator.h
//  04函数式编程
//
//  Created by beyond on 2017/12/11.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject
@property (nonatomic,assign)int result;

// 返回值是本身
// 参数是一个block;
// block的参数是外部控制器要操作的成员变量result
// block的返回值是外部控制器操作完成后的结果数值
- (instancetype)add:(int (^)(int result))block;
@end
