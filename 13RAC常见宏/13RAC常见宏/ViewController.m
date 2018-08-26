//
//  ViewController.m
//  13RAC常见宏
//
//  Created by beyond on 2017/12/27.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rac_define_1];
    [self rac_define_2];
    [self rac_define_3];
    [self rac_define_4];
}
- (void)rac_define_4
{
    // 元组的包装和解包
    // 将参数们包装成元组
    RACTuple *tuple = RACTuplePack(@"龙与虎",@"逢坂大河");
    NSLog(@"sg_%@_%@",tuple[0],tuple[1]);
    
    // 将元组解包
    RACTupleUnpack(NSString *anime,NSString *actress) = tuple;
    NSLog(@"sg_%@_%@",anime,actress);
}
- (void)rac_define_3
{
    // 解决block的循环引用问题,下面两个配套使用,外面+block里面
    // 详细示例见NextViewCtrl
    // @weakify(self)
    // @strongify(self)
}

- (void)rac_define_2
{
    // 监听某个对象的某个属性,返回值为信号
    // 比如:监听label的文本,转化成信号
    [RACObserve(_titleLabel, text) subscribeNext:^(id  _Nullable newTextValue) {
        NSLog(@"sg_%@",newTextValue);
    }];
}
- (void)rac_define_1
{
    // 对某个对象的某个属性绑定
    // 比如:将label的文字 与 输入框的文本signal进行绑定
    RAC(_titleLabel,text) = _textField.rac_textSignal;
    
    
}

@end
