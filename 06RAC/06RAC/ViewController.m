//
//  ViewController.m
//  06RAC
//
//  Created by beyond on 2017/12/12.
//  Copyright © 2017年 beyond. All rights reserved.


#import "ViewController.h"
#import "ReactiveObjC.h"
@interface ViewController ()
// 用一个成员变量,保存一下 信号内部创建的订阅者,防止信号被自动取消订阅(以便将来自己手动用RACDisposable取消订阅)
@property (nonatomic,strong) id <RACSubscriber> subscriber;
// 用一个成员变量,保存一下,以便将来自己手动用取消订阅
@property (nonatomic,strong) RACDisposable *disposable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.创建信号时,block_didSubscribe代码并未执行(只有在订阅了信号之后,才会执行block_didSubscribe)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        _subscriber = subscriber;
        
        // block_didSubscribe的作用是:描述当前信号的哪些数据需要发送
        // block_didSubscribe会被保存到RACDynamicSignal的成员变量里
        NSLog(@"sg_1_信号成功被激活,即将发送新的信号值");
        
        // 3.只有订阅者RACPassthroughSubscriber才能发送信号的新值
        [subscriber sendNext:@"新的信号值1"];
        NSLog(@"sg_3_发送信号完毕");
        
        return [RACDisposable disposableWithBlock:^{
            // 默认会自动来到这个代码,一般作为信号被取消订阅时的清理收尾工作
            
            // 注:但是,只要订阅者还在,就不会自动取消信号订阅(因此,要用成员变量保存一下subscriber)
            NSLog(@"sg_4_清理收尾");
        }];
    }];
    
    
    NSLog(@"sg_即将订阅信号");
    
    // 2.只有订阅信号后,默认的冷信号才会变成热信号!
    // nextBlockAfterValueChanged是当收到发送的信号改变后的新值时,要执行的代码
    // 作用:2.1.创建订阅者
    // 作用:2.2 .把nextBlockAfterValueChanged保存在了订阅者的成员变量里
    
    _disposable = [signal subscribeNext:^(id  _Nullable newValue) {
        // 只要[subscriber sendNext:@"新的信号值1"],就会调用这个nextBlockAfterValueChanged
        NSLog(@"sg_2_当订阅的信号发生改变时,要执行的代码_%@",newValue);
    }];
    
    
    // 手动取消信号订阅
    [_disposable dispose];
    
}







@end



/*
 *	信号类(RACSiganl)，它本身不具备发送信号的能力，而是交给内部一个<订阅者>去发送新数据。
    默认一个信号都是冷信号，只有这个信号被订阅了，这个信号才会变为热信号。
 
 *	如何订阅信号：调用信号RACSignal的subscribeNext就能订阅了。
 */

// RACSignal使用步骤：
// 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
// 2.订阅信号,就会激活信号. RACDynamicSignal的方法- (RACDisposable *)subscribeNext:(void (^)(id newValue))nextBlockAfterValueChanged
// 3.由订阅者 发送信号.RACPassthroughSubscriber的方法 - (void)sendNext:(id)value


// RACSignal底层实现：
// 1.创建信号时，首先把block_didSubscribe保存到信号(RACDynamicSignal)的成员变量中.

// 2.当信号被订阅，也就是调用RACDynamicSignal的方法- (RACDisposable *)subscribeNext:(void (^)(id newValue))nextBlockAfterValueChanged时.注意:nextBlockAfterValueChanged实际就是观察到信号改变后,要响应的操作
// 2.1 在上面的subscribeNext方法内部,会创建订阅者RACPassthroughSubscriber，并且把nextBlockAfterValueChanged保存到订阅者subscriber的成员变量中。
// 2.2 subscribeNext的方法内部会调用信号signal的成员变量block_didSubscribe,使信号变成了热信号.

// 3.在信号siganl的block_didSubscribe中执行[subscriber sendNext:@"signal_newValue"]方法,即可以告诉订阅者信号变化后的新值.
// 3.1 [subscriber sendNext:@"signal_newValue"]的底层于是会执行subscriber的成员变量nextBlockAfterValueChanged
