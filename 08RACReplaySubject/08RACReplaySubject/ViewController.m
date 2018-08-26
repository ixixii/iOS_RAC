//
//  ViewController.m
//  08RACReplaySubject
//
//  Created by beyond on 2017/12/26.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 0.RACReplaySubject可先发送信号,再订阅信号
    
    // 1.创建信号(RACReplaySubject新增了一个成员变量valuesReceived)
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 3.发送信号仅仅是:将newValue保存到valuesArray中;
    // 然后调用父类RACSubject的sendNext方法:遍历所有的订阅者,将新数据发送出去
    // 如果暂时还没有创建订阅者时(尚未被订阅),则不发送任何数据
    [replaySubject sendNext:@"这个是新值"];
    // 2.创建订阅者
    // 注:会遍历valuesArray中所有的值,让新建的订阅者,[subscriber sentNext:value](即:执行下面的block)
    // 目的就是:让该新建的订阅者获得valuesArray中所有的新值
    [replaySubject subscribeNext:^(id  _Nullable newValue) {
        NSLog(@"sg_newValue:%@",newValue);
    }];
}

@end
