//
//  ViewController.m
//  10RAC集合类
//
//  Created by beyond on 2017/12/26.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"
#import "MJExtension.h"
#import "AnimeModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self tuple];
    // [self sequence_arr];
    // [self sequence_dic];
    [self sequence_dictArrToModelArr];
    
}
- (void)sequence_dictArrToModelArr
{
    // 将从Plist转化而来的字典数组,转成对象数组
    NSArray *dictArrFromPlist = @[
                                  @{@"anime":@"k-on",
                                    @"actress":@"平泽唯"
                                   },
                                  
                                  @{@"anime":@"龙与虎",
                                    @"actress":@"逢坂大河"
                                   },
                                  
                                  @{@"anime":@"未闻花名",
                                    @"actress":@"面码"
                                    },
                                  @{@"anime":@"狼与香辛料",
                                    @"actress":@"赫萝"
                                    },
                                  @{@"anime":@"俺妹",
                                    @"actress":@"黑猫"
                                    }
                                ];
    NSMutableArray *modelArr = [NSMutableArray array];
    // 方法1:遍历信号的每一个值(即dict)
    [dictArrFromPlist.rac_sequence.signal subscribeNext:^(NSDictionary *dict) {
        AnimeModel *model = [AnimeModel mj_objectWithKeyValues:dict];
        [modelArr addObject:model];
    }];
    
    // 方法2:直接mjextension
    modelArr = [AnimeModel mj_objectArrayWithKeyValuesArray:dictArrFromPlist];
    NSLog(@"sg_modelArr:%@",modelArr);
    
    // 方法3:sequence高级用法map
    NSArray *modelArr2 = [[dictArrFromPlist.rac_sequence map:^id _Nullable(NSDictionary *dict) {
        // block返回一个对象,从遍历中的字典转化而来的对象,重新放回到sequence集合里
        return [AnimeModel mj_objectWithKeyValues:dict];
        
        // 最后将转化完成的Sequence集合,转成NSArray
    }] array];
    NSLog(@"sg_modelArr2:%@",modelArr2);
    
    
    
    
    
    
    
    
}
- (void)sequence_dic
{
    // RAC中的集合类,用于统一数组和字典
    NSDictionary *dic = @{
                          @"k-on":@"平泽唯",
                          @"龙与虎":@"逢坂大河",
                          @"未闻花名":@"面码",
                          @"狼与香辛料":@"赫萝",
                          @"俺妹":@"黑猫"
                          };
    [dic.rac_sequence.signal subscribeNext:^(RACTwoTuple  *obj) {
//        NSString *key = obj[0];
//        NSString *value = obj[1];
//        NSLog(@"sg_遍历:%@_%@",key,value);
        
        
        // 或者使用:强大的宏
        RACTupleUnpack(NSString *key,NSString *value) = obj;
        NSLog(@"sg_遍历:%@_%@",key,value);
    }];
}
- (void)sequence_arr
{
    // RAC中的集合类,用于统一数组和字典
    NSArray *arr = @[@"k-on",@"大河",@"面码",@"赫萝",@"黑猫"];
    // 1.数组先转成sequence
    RACSequence *sequence = arr.rac_sequence;
    // 2.sequence再转成信号
    RACSignal *signal = sequence.signal;
    // 3.再订阅信号,则会自动遍历
    [signal subscribeNext:^(id  _Nullable obj) {
        NSLog(@"sg_遍历:%@",obj);
    }];
    
    
    // 综上所述
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable obj) {
        NSLog(@"sg_遍历2:%@",obj);
    }];
}

- (void)tuple
{
    // 类似于NSArray,只能放对象
    RACTuple *tuple = [RACTuple tupleWithObjects:@"N2",@"N1",@2018, nil];
    NSLog(@"sg_%@",tuple);
    NSLog(@"sg_%@",tuple[0]);
}




@end
