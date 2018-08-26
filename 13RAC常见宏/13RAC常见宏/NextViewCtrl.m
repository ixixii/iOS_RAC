//
//  NextViewCtrl.m
//  13RAC常见宏
//
//  Created by beyond on 2017/12/27.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "NextViewCtrl.h"
#import "ReactiveObjC.h"

@interface NextViewCtrl ()
@property (nonatomic,strong) RACSignal *signal;

@end

@implementation NextViewCtrl
- (IBAction)dismissBtnClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 演示 循环引用,出现内存泄露(控制器dismiss时dealloc没被调用)
    // [self rac_define_memoryleak];
    
    // 使用宏避免循环引用
    [self rac_define_avoidMemoryLeak];
    
    
}

// 使用宏避免循环引用
- (void)rac_define_avoidMemoryLeak
{
    // 先对self弱引用 (必须成对使用)
    // 相当于把self变成弱指针
    @weakify(self);
    
    // 双方强引用的时候,会出现内存泄露
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 再在代码块内强引用 (必须成对使用)
        // 对弱指针 又进行 强引用,目的是保证在代码块中不被销毁;强引用的范围仅限于代码块
        @strongify(self);
        
        
        // 经过上面的处理后,block中使用self已经不是一个强指针了
        NSLog(@"sg__ctrl的self已经不会出现循环引用了_%@",self);
        return nil;
    }];
    
    // self又对signal进行了强引用 (strong 属性的成员变量)
    _signal = signal;
}

// 演示 循环引用,出现内存泄露(控制器dismiss时dealloc没被调用)
- (void)rac_define_memoryleak
{
    // 双方强引用的时候,会出现内存泄露
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // block中使用self,会对self进行了强引用
        NSLog(@"sg__ctrl被强引用,无法被销毁_%@",self);
        return nil;
    }];
    
    // self又对signal进行了强引用 (strong 属性的成员变量)
    _signal = signal;
}

- (void)dealloc
{
    NSLog(@"sg__dealloc__安全销毁__无内存泄漏");
}

@end
