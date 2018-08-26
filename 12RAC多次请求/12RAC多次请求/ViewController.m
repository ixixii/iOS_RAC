//
//  ViewController.m
//  12RAC多次请求
//
//  Created by beyond on 2017/12/27.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self rac_lift_selector];
}

- (void)rac_lift_selector
{
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"sg_模拟网络操作1");
        
        [subscriber sendNext:@"sg_返回的网络数据1"];
        return nil;
    }];
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"sg_模拟网络操作2");
        
        [subscriber sendNext:@"sg_返回的网络数据2"];
        return nil;
    }];
    
    NSArray *signalArr = @[signal1,signal2];
    // rac 实现 所有网络请求都完成的时候,才更新UI操作
    // 注意:所有请求完成时才执行的方法的 参数 必须 和信号的个数 一一对应
    [self rac_liftSelector:@selector(updateUIWithData1:andData2:) withSignalsFromArray:signalArr];
}
- (void)updateUIWithData1:(id)x1 andData2:(id)x2
{
    NSLog(@"sg_所有请求都完成时,才被执行_x1:%@,x2:%@",x1,x2);
}

@end
