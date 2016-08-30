//
//  StudentInfoModel.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StudentSubject :NSObject

/** 学科*/
@property (nonatomic ,copy)NSString *subject;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade;

@end

@interface StudentInfoModel : NSObject

/** 学生名称*/
@property (nonatomic ,copy)NSString *stuName;
/** 学生年龄*/
@property (nonatomic ,copy)NSString *stuAge;
/** 学生年级*/
@property (nonatomic ,copy)NSString *stuGrade;
/** 备注*/
@property (nonatomic ,copy)NSString *stuRemarks;
/** 学生ID*/
@property (nonatomic ,copy)NSString *stuID;
/** 学科信息*/
@property (nonatomic ,strong)NSMutableArray <StudentSubject *>*subjectArray;

- (void)localNotifition;


@end
