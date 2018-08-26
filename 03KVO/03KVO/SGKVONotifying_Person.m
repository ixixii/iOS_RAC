//
//  SGKVONotifying_Person.m
//  03KVO
//
//  Created by beyond on 2017/12/11.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "SGKVONotifying_Person.h"
#import <objc/runtime.h>
@implementation SGKVONotifying_Person
// 自己实现KVO的底层
- (void)setAge:(int)age
{
    // 1.正常赋值
    [super setAge:age];
    
    // 2.当age值改变的时候,通过运行时获取前面保存的观察者
    id observer_ctrl = objc_getAssociatedObject(self, "observer_ctrl");
    // 3.调用观察者observer_ctrl的方法,告知age已改变
    [observer_ctrl observeValueForKeyPath:@"age" ofObject:self change:nil context:nil];
}
@end
