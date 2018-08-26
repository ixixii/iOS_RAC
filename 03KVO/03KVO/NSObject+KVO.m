//
//  NSObject+KVO.m
//  03KVO
//
//  Created by beyond on 2017/12/11.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "NSObject+KVO.h"

// 修改isa指针时,保存观察者时用到运行时
#import <objc/runtime.h>

@implementation NSObject (KVO)
// 添加分类,自己实现一个addObserver方法
- (void)sg_addObserver:(NSObject *)observer_ctrl forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context
{
//    KVO底层实现:
//    1.动态创建新类:NSKVONotifying_Person,NSKVONotifying_Person是Person子类,以作KVO用
//    2.修改当前对象p的isa指针->NSKVONotifying_Person
//    3.只要调用对象p的set,就会调用新类的NSKVONotifying_Person的set方法
//    4.重写新类NSKVONotifying_Person的set方法,1.[super set:] 2.通知观察者,告诉你属性改变
    
    
    //1.改变isa指向自己实现KVO用到的的一个Person的子类
    object_setClass(self, NSClassFromString(@"SGKVONotifying_Person"));
    //2.给分类关联一个新的成员变量
    objc_setAssociatedObject(self, "observer_ctrl", observer_ctrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
@end
