//
//  ViewController.m
//  07RACSubject
//
//  Created by beyond on 2017/12/13.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // RACSubject既可以充当信号,又可以发送信号!因为继承自RACSignal并实现了RACSubscriber协议
    
    // 1.创建RACSubject信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号(RACSubject必须先订阅,再发送信号)
    // 不同的信号,处理订阅的方式不一样!!!
    // RACSubject处理订阅:仅仅是将创建的订阅者 到 成员变量数组里(subscribers)
    [subject subscribeNext:^(id  _Nullable newValue) {
        NSLog(@"sg_第1个订阅者_newValue:%@",newValue);
    }];
    
    // 注:因为是成员变量数组,所以可以多次订阅(会创建一个新的订阅者,并加入到成员变量数组里)
    [subject subscribeNext:^(id  _Nullable newValue) {
        NSLog(@"sg_第2个订阅者_newValue:%@",newValue);
    }];
    // 3.发送信号
    [subject sendNext:@"这个是要发送给订阅者的新信号值"];
    
    
    
    // 总结:核心思想,2点:
    // 底层实现:遍历成员数组里的所有订阅者,调用其nextBlock
    
    // 执行流程:
    
    // RACSubject被订阅,仅仅是保存创建的订阅者 到成员变量数组里(subscribers)
    // RACSubject发送数据,遍历成员变量数组里的所有的订阅者,然后调用他们的nextBlock
    
}


@end
