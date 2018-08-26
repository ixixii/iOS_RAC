//
//  RedView.h
//  09RACSubjectDemo
//
//  Created by beyond on 2017/12/26.
//  Copyright © 2017年 beyond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"
@interface RedView : UIView
// 强引用
@property (nonatomic,strong) RACSubject *btnClickSignal;
- (IBAction)btnClicked:(UIButton *)sender;
@end
