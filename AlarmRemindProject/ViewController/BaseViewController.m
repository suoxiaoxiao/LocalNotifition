//
//  BaseViewController.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>
{
    UIGestureRecognizer *gesture;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    if (self.navigationController.viewControllers.count<=1) {
        //        [self.myNavBar.backBtn removeFromSuperview];
        return;
    }
    
    _popRecognizer = [[UIPanGestureRecognizer alloc] init];
    _popRecognizer.delegate = self;
    _popRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_popRecognizer];
    
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    //    /**
    //     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
    //     */
    id gestureRecognizerTarget = [_targets firstObject];
    //    /**
    //     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
    //     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    //    /**
    //     *  通过前面的打印，我们从控制台获取出来它的方法签名。
    //     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    //    /**
    //     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
    //     */
    [_popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (gesture != nil) {
        return;
    }
    
    gesture = self.navigationController.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    
    [self.view removeGestureRecognizer:self.popRecognizer];
    
    _popRecognizer = [[UIPanGestureRecognizer alloc] init];
    _popRecognizer.delegate = self;
    _popRecognizer.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:_popRecognizer];
    
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    //    /**
    //     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
    //     */
    id gestureRecognizerTarget = [_targets firstObject];
    //    /**
    //     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
    //     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    //    /**
    //     *  通过前面的打印，我们从控制台获取出来它的方法签名。
    //     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    //    /**
    //     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
    //     */
    [_popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint point = [gestureRecognizer translationInView:self.view];
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return /*self.navigationController.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue] &&*/ (point.x>0 /*&& abs(point.y) < 20*/);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
