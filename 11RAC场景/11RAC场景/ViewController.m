//
//  ViewController.m
//  11RAC场景
//
//  Created by beyond on 2017/12/26.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "UIView+Frame.h"
// 注:rac_observeKeyPath的方法,默认情况下,并没有导入到主头文件中,需手动导入
#import "NSObject+RACKVOWrapper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 0.判断方法是否被执行
    // [self rac_signal_for_selector];
    // [self rac_signal_for_selector2];
    
    // 1.rac代替代理
    // [self rac_replace_delegate];

    // 2.rac代替KVO
    // [self rac_replace_kvo];
    // [self rac_replace_kvo2];
    
    // 3.rac监听事件,如按钮点击
    // [self rac_replace_controlEvent];
    
    // 4.rac代替通知
    // [self rac_replace_notification];
    
    // 5.监听文本框的文字
    [self rac_replace_textFieldListen];
    

    
}

- (void)rac_replace_textFieldListen
{
    // rac 监听 文本的改变
    [[_textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"sg__textField has changed:%@",x);
    }];
}
- (void)rac_replace_notification
{
    // rac代替通知,将通知中心监听到的通知转成信号
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable concretNotification) {
        /*
         sg_监听到了键盘将要弹出的通知:NSConcreteNotification 0x6000002562f0 {name = UIKeyboardWillShowNotification; userInfo = {
         UIKeyboardAnimationCurveUserInfoKey = 7;
         UIKeyboardAnimation Duration UserInfoKey = "0.25";
         UIKeyboard Bounds UserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
         UIKeyboard CenterBegin UserInfoKey = "NSPoint: {160, 460}";
         UIKeyboard CenterEnd UserInfoKey = "NSPoint: {160, 441.5}";
         UIKeyboard FrameBegin UserInfoKey = "NSRect: {{0, 352}, {320, 216}}";
         UIKeyboard FrameEnd UserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
         UIKeyboard IsLocal UserInfoKey = 1;
         }}
         */
        NSLog(@"sg_监听到了键盘将要 弹出 的通知:%@",concretNotification);
    }];
    
    
    
    // rac代替通知,将通知中心监听到的通知转成信号
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardDidHideNotification object:nil] subscribeNext:^(NSNotification * _Nullable concretNotification) {
        /*
         sg_监听到了键盘将要关闭的通知:NSConcreteNotification 0x600000243ed0 {name = UIKeyboardDidHideNotification; userInfo = {
         
         UIKeyboard Bounds UserInfoKey = "NSRect: {{0, 0}, {320, 253}}";
         UIKeyboard CenterBegin UserInfoKey = "NSPoint: {160, 441.5}";
         UIKeyboard CenterEnd UserInfoKey = "NSPoint: {160, 694.5}";
         UIKeyboard FrameBegin UserInfoKey = "NSRect: {{0, 315}, {320, 253}}";
         UIKeyboard FrameEnd UserInfoKey = "NSRect: {{0, 568}, {320, 253}}";
         
         }}

         */
        NSLog(@"sg_监听到了键盘将要 关闭 的通知:%@",concretNotification);
    }];
    
    
}
- (void)rac_replace_controlEvent
{
    // rac监听按钮点击事件,将事件转化成signal
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable btn) {
        // sg_监听到了按钮的controlEvent:<UIButton: 0x7fcb16507130; frame = (83.5 144; 153 30); opaque = NO; autoresize = RM+BM; layer = <CALayer: 0x610000232b20>>
        NSLog(@"sg_监听到了按钮的controlEvent:%@",btn);
    }];
}
- (void)rac_replace_kvo2
{
    // rac代替kvo,监听redView的frame发生新值的改变
    [[_redView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable newValue) {
        // 启动时就打印了一次sg_newValue:NSRect: {{67.5, 273.5}, {240, 120}}
        // touch屏幕时,又打印了一次sg_newValue:NSRect: {{0, 224}, {240, 120}}
        NSLog(@"sg_newValue:%@",newValue);
    }];
}
- (void)rac_replace_kvo
{
    // rac代替kvo,监听redView的frame发生新值的改变
    // 注意,此方法的缺点是:
    // rac_observeKeyPath的方法,默认情况下,并没有导入到主头文件中,需手动导入
    [_redView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        // sg_NSRect: {{0, 224}, {240, 120}}
        // 注意:NS开头为NextStep,与Mac开发同源
        NSLog(@"sg_%@",value);
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _redView.x = 0;
}
- (void)rac_signal_for_selector2
{
    // 控制器 监听redView中的按钮有没有被点击
    // 好处是:监听某个对象有没有调用某个方法
    // 坏处是:不能传递参数(要传递数据就用RACSubject)
    [[_redView rac_signalForSelector:@selector(btnClicked:)]subscribeNext:^(RACTuple * _Nullable x) {
        /*
         <RACTuple: 0x61800001b890> (
         "<UIButton: 0x7ff1b5e08570; frame = (137 269; 46 30); opaque = NO; autoresize = RM+BM; layer = <CALayer: 0x608000038540>>"
         )
         */
        NSLog(@"sg_控制器 感知到了 redView中的btnClick_%@",x);
    }];
}
- (void)rac_signal_for_selector
{
    
    // 将方法订阅成信号,从而判断方法是否被触发(执行)
    // 好处是:监听某个对象有没有调用某个方法
    // 坏处是:不能传递参数(要传递数据就用RACSubject)
    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(RACTuple * _Nullable x) {
        // x是一个空的RACTuple
        NSLog(@"sg_控制器的didReceiveMemoryWarning方法被触发了_%@",x);
    }];
}

- (void)rac_replace_delegate
{
    // 参照RACSubject那个示例代码
}


@end
