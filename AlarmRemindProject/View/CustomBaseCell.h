//
//  CustomBaseCell.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentInfoModel.h"

@interface CustomBaseCell : UIView


@property (nonatomic ,strong)StudentSubject *model;

- (instancetype)initWithText:(NSString *)text Title:(NSString *)title;

@end
