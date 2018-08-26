//
//  ViewController.m
//  03KVO
//
//  Created by beyond on 2017/12/10.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
// 触摸屏幕一下,年纪age++,通知观察者,在代理方法中打印变化的age
#import "Person.h"
#import "NSObject+KVO.h"
@interface ViewController ()

@property (nonatomic,strong)Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc]init];
    _p = p;
    
    // 使用自己的KVO,添加观察者
    [p sg_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"sg__%d",_p.age);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 每点击次一屏幕,就调用set方法,改变age;
    _p.age ++;
    // _p->_age ++; // 不会触发,因为没有执行set方法
}
@end
