//
//  Person.h
//  03KVO
//
//  Created by beyond on 2017/12/10.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    // 只有指定为public之后,才可以直接使用->访问
    @public int _age;
}

@property (nonatomic,assign) int age;
@end
