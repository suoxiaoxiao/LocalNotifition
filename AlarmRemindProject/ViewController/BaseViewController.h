//
//  BaseViewController.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


//如果哪个界面不需要滑动返回，可以将手势移除掉
// 在- (void)viewDidLoad 中添加此方法
// [self.view removeGestureRecognizer:self.popRecognizer];

@property(nonatomic,retain)UIPanGestureRecognizer *popRecognizer;

@end
