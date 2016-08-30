//
//  StudentInfoCell.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/24.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentInfoModel.h"

@interface StudentInfoCell : UITableViewCell

@property (nonatomic ,strong)StudentInfoModel *model;

@property (nonatomic ,strong)UITextField *nameLabel;
@property (nonatomic ,strong)UITextField *ageLabel;
@property (nonatomic ,strong)UITextField *gradeLabel;

- (void)canEditing:(BOOL)editing;

@end
