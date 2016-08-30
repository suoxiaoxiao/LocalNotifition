//
//  StudentListCell.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentInfoModel.h"

@interface StudentListCell : UITableViewCell

@property (nonatomic ,strong)StudentInfoModel *model;

- (void)showTopLine;
- (void)hideTopLine;

@end
