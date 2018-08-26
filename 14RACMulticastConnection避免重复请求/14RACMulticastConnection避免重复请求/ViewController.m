//
//  ViewController.m
//  14RACMulticastConnection避免重复请求
//
//  Created by beyond on 2017/12/27.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"

#import "NAKPlaybackIndicatorView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 重复请求demo
    // [self rac_multiconnection];
    
    [self addMusicIndicatorView];
    
    // 使用RACMulticastConnection避免重复请求
    [self rac_avoid_multi_connection];
    
}
- (void)addMusicIndicatorView
{
    NAKPlaybackIndicatorViewStyle *style = [NAKPlaybackIndicatorViewStyle iOS7Style];
    NAKPlaybackIndicatorView *indicator = [[NAKPlaybackIndicatorView alloc] initWithStyle:style];
    
    indicator.frame = CGRectMake(100, 100, 30, 30);
//    indicator.hidden = NO;
    
    NSLog(@"sg___%@",indicator);
    [self.view addSubview:indicator];
    [indicator sizeToFit];
    
    // Initially the `state` property is NAKPlaybackIndicatorViewStateStopped
    // and the `hidesWhenStopped` property is YES.
    // Thus, the view is hidden at this time.
    
    
    
    // The bars stop animation and become idle.
    indicator.state = NAKPlaybackIndicatorViewStatePaused;
    
    // The view becomes hidden.
    indicator.state = NAKPlaybackIndicatorViewStateStopped;
    
    // The view appears and the bars start animation.
    indicator.state = NAKPlaybackIndicatorViewStatePlaying;
}
// 使用RACMulticastConnection避免重复请求
- (void)rac_avoid_multi_connection
{
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"sg_模拟网络请求,下载数据");
        [subscriber sendNext:@"这是下载回来的新数据"];
        
        return nil;
    }];
    
    // 2.将源冷信号 转成 连接
    RACMulticastConnection *mConnection = [signal publish];
    
    // 3.订阅 将连接的信号 (而非源信号)
    [mConnection.signal subscribeNext:^(id  _Nullable newValueFromWeb) {
        NSLog(@"订阅者1,看到了请求回的最新数据:%@",newValueFromWeb);
    }];
    
    // 3.订阅 将连接的信号 (而非源信号)
    [mConnection.signal subscribeNext:^(id  _Nullable newValueFromWeb) {
        NSLog(@"订阅者2,看到了请求回的最新数据:%@",newValueFromWeb);
    }];
    
    // 4.进行连接(只有连接后,源信号才被订阅,才成为热信号,触发block中的任务)
    // 注:在connect方法执行之后,再订阅的订阅者,收不到请求回来的最新数据!
    [mConnection connect];
    
    
}


- (void)rac_multiconnection
{
    // 一个信号里需要进行网络请求时,当该信号被多次订阅的时候,很可能只是想得到其请求回来的数据,而非多次去请求网络
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"sg_模拟网络请求,下载数据");
        
        [subscriber sendNext:@"这是下载回来的新数据"];
        return nil;
    }];
    
    [signal subscribeNext:^(id  _Nullable newValueFromWeb) {
        NSLog(@"订阅者1,看到了请求回的最新数据:%@",newValueFromWeb);
    }];
    
    [signal subscribeNext:^(id  _Nullable newValueFromWeb) {
        NSLog(@"订阅者2,看到了请求回的最新数据:%@",newValueFromWeb);
    }];
    
    /*
     运行结果:(发现有2个订阅者时,就会2次重复请求同样的网络数据)
     2017-12-27 13:28:14.150  sg_模拟网络请求,下载数据
     2017-12-27 13:28:14.150  订阅者1,看到了请求回的最新数据:这是下载回来的新数据
     2017-12-27 13:28:14.151  sg_模拟网络请求,下载数据
     2017-12-27 13:28:14.151  订阅者2,看到了请求回的最新数据:这是下载回来的新数据

     */
}



@end
