//
//  NSObject+Calculator.h
//  02Calculator
//
//  Created by beyond on 2017/12/10.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorMaker.h"
@interface NSObject (Calculator)
+(int)makeCalculator:(void (^)(CalculatorMaker *))block;
@end
