//
//  NSObject+KVO.h
//  03KVO
//
//  Created by beyond on 2017/12/11.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KVO)
// 添加分类,自己实现一个addObserver方法
- (void)sg_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
@end
