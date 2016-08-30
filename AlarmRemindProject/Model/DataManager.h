//
//  DataManager.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentInfoModel.h"

@interface DataManager : NSObject

/** 学生名称*/
@property (nonatomic ,copy)NSString *stuName;
/** 学生年龄*/
@property (nonatomic ,copy)NSString *stuAge;
/** 学生年级*/
@property (nonatomic ,copy)NSString *stuGrade;
/**备注*/
@property (nonatomic ,copy)NSString *stuRemarks;
/**学生ID*/
@property (nonatomic ,copy)NSString *stuID;

/** 学科*/
@property (nonatomic ,copy)NSString *subject1;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher1;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period1;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade1;

/** 学科*/
@property (nonatomic ,copy)NSString *subject2;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher2;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period2;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade2;

/** 学科*/
@property (nonatomic ,copy)NSString *subject3;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher3;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period3;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade3;

/** 学科*/
@property (nonatomic ,copy)NSString *subject4;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher4;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period4;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade4;

/** 学科*/
@property (nonatomic ,copy)NSString *subject5;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher5;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period5;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade5;

/** 学科*/
@property (nonatomic ,copy)NSString *subject6;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher6;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period6;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade6;

/** 学科*/
@property (nonatomic ,copy)NSString *subject7;
/** 学科老师*/
@property (nonatomic ,copy)NSString *teacher7;
/** 学科时段*/
@property (nonatomic ,copy)NSString *period7;
/** 学科班级*/
@property (nonatomic ,copy)NSString *grade7;

/**初始化数据库*/
+(void)initCreatDatabase;
/**增加数据*/
+ (void)addData:(StudentInfoModel *)model;
/**删除数据*/
+ (void)deleteData:(StudentInfoModel *)model;
/**更改数据*/
+ (void)replaceData:(StudentInfoModel *)model;
/**查看数据*/
+ (NSMutableArray *)getData;
@end
