//
//  StudentInfoFooterView.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/24.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentInfoModel.h"

@interface StudentInfoFooterView : UIView

@property (nonatomic ,strong)StudentInfoModel *model;
@property (nonatomic ,strong)UITextView *remarksLabel;
@end
