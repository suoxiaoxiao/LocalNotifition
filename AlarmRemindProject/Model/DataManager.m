//
//  DataManager.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "DataManager.h"
#import <FMDB.h>

@implementation DataManager

 static  FMDatabase *db;

+(void)initCreatDatabase
{
    db = [[FMDatabase alloc] initWithPath:[self path]];
    
    [db open];
    
    [db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(ID INTEGER PRIMARY KEY AUTOINCREMENT,stuName TEXT,stuAge TEXT,stuGrade TEXT,stuRemarks TEXT,stuID TEXT,subject1 TEXT,teacher1 TEXT,period1 TEXT, grade1 TEXT,subject2 TEXT,teacher2 TEXT,period2 TEXT, grade2 TEXT,subject3 TEXT,teacher3 TEXT,period3 TEXT, grade3 TEXT,subject4 TEXT,teacher4 TEXT,period4 TEXT,grade4 TEXT,subject5 TEXT,teacher5 TEXT,period5 TEXT, grade5 TEXT,subject6 TEXT,teacher6 TEXT,period6 TEXT,grade6 TEXT,subject7 TEXT,teacher7 TEXT,period7 TEXT,grade7 TEXT)",DataBaseName]];
    
    [db close];
    
}

+(NSString*)path
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.sqlite"];
}

//增加数据
+ (void)addData:(StudentInfoModel *)model
{
    DataManager*info = [DataManager withModel:model];
    [db open];
    /*
     stuName TEXT,stuAge TEXT,stuGrade TEXT,subject1 TEXT,teacher1 TEXT,period1 TEXT,subject2 TEXT,teacher2 TEXT,period2 TEXT,subject3 TEXT,teacher3 TEXT,period3 TEXT,subject4 TEXT,teacher4 TEXT,period4 TEXT,subject5 TEXT,teacher5 TEXT,period5 TEXT,subject6 TEXT,teacher6 TEXT,period6 TEXT,subject7 TEXT,teacher7 TEXT,period7 TEXT,
     */
    
    NSString *propertyName = @"'stuName', 'stuAge', 'stuGrade','stuRemarks','stuID','subject1', 'teacher1', 'period1', 'grade1','subject2', 'teacher2', 'period2','grade2','subject3', 'teacher3', 'period3', 'grade3','subject4', 'teacher4', 'period4','grade4','subject5', 'teacher5', 'period5', 'grade5','subject6', 'teacher6', 'period6','grade6','subject7', 'teacher7', 'period7','grade7'";
    NSString *valueStr = [NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@', '%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'",
                          KGetStringExit(info.stuName),KGetStringExit(info.stuAge),KGetStringExit(info.stuGrade),KGetStringExit(info.stuRemarks),KGetStringExit(info.stuID),
                          KGetStringExit(info.subject1),KGetStringExit(info.teacher1),KGetStringExit(info.period1),KGetStringExit(info.grade1),
                          KGetStringExit(info.subject2),KGetStringExit(info.teacher2),KGetStringExit(info.period2),KGetStringExit(info.grade2),
                          KGetStringExit(info.subject3),KGetStringExit(info.teacher3),KGetStringExit(info.period3),KGetStringExit(info.grade3),
                          KGetStringExit(info.subject4),KGetStringExit(info.teacher4),KGetStringExit(info.period4),KGetStringExit(info.grade4),
                          KGetStringExit(info.subject5),KGetStringExit(info.teacher5),KGetStringExit(info.period5),KGetStringExit(info.grade5),
                          KGetStringExit(info.subject6),KGetStringExit(info.teacher6),KGetStringExit(info.period6),KGetStringExit(info.grade6),
                          KGetStringExit(info.subject7),KGetStringExit(info.teacher7),KGetStringExit(info.period7),KGetStringExit(info.grade7)];
    
    NSString *insertSql1= [NSString stringWithFormat:
                           @"INSERT INTO '%@' (%@) VALUES (%@)",DataBaseName,propertyName,valueStr];
    
    BOOL res = [db executeUpdate:insertSql1];
    
    if (res) {
        NSLog(@"success to insert db table");
    }else{
        NSLog(@"error when insert db table");
    }
    
    [db close];
}
//删除数据
+ (void)deleteData:(StudentInfoModel *)model
{
    DataManager*info = [DataManager withModel:model];
    [db open];
    [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE stuID=?",DataBaseName],info.stuID];
    [db close];
}
//更改数据
+ (void)replaceData:(StudentInfoModel *)model
{
    DataManager*info = [DataManager withModel:model];
    
    [db open];
//    NSString *propertyName = @"stuName = ?, stuAge = ?, stuGrade = ?,subject1 = ?, teacher1 = ?, period1 = ?,subject2 = ?, teacher2 = ?, period2 = ?,subject3 = ?, teacher3 = ?, period3 = ?,subject4 = ?, teacher4 = ?, period4 = ?,subject5 = ?, teacher5 = ?, period5 = ?,subject6 = ?, teacher6 = ?, period6 = ?,subject7 = ?, teacher7 = ?, period7 = ?";
//    NSString *valueStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",
//                          KGetStringExit(info.stuName),KGetStringExit(info.stuAge),KGetStringExit(info.stuGrade),
//                          KGetStringExit(info.subject1),KGetStringExit(info.teacher1),KGetStringExit(info.period1),
//                          KGetStringExit(info.subject2),KGetStringExit(info.teacher2),KGetStringExit(info.period2),
//                          KGetStringExit(info.subject3),KGetStringExit(info.teacher3),KGetStringExit(info.period3),
//                          KGetStringExit(info.subject4),KGetStringExit(info.teacher4),KGetStringExit(info.period4),
//                          KGetStringExit(info.subject5),KGetStringExit(info.teacher5),KGetStringExit(info.period5),
//                          KGetStringExit(info.subject6),KGetStringExit(info.teacher6),KGetStringExit(info.period6),
//                          KGetStringExit(info.subject7),KGetStringExit(info.teacher7),KGetStringExit(info.period7)];
    
    
    [db executeUpdate:@"UPDATE studentInfo SET stuName = ?, stuAge = ?, stuGrade = ?,stuRemarks = ?,stuID = ?,subject1 = ?, teacher1 = ?, period1 = ?,grade1 = ?,subject2 = ?, teacher2 = ?, period2 = ?,grade2 = ?,subject3 = ?, teacher3 = ?, period3 = ?,grade3 = ?,subject4 = ?, teacher4 = ?, period4 = ?,grade4 = ?,subject5 = ?, teacher5 = ?, period5 = ?,grade5 = ?,subject6 = ?, teacher6 = ?, period6 = ?,grade6 = ?,subject7 = ?, teacher7 = ?, period7 = ?,grade7 = ? WHERE stuID=?",KGetStringExit(info.stuName),KGetStringExit(info.stuAge),KGetStringExit(info.stuGrade),KGetStringExit(info.stuRemarks),KGetStringExit(info.stuID),
     KGetStringExit(info.subject1),KGetStringExit(info.teacher1),KGetStringExit(info.period1),KGetStringExit(info.grade1),
     KGetStringExit(info.subject2),KGetStringExit(info.teacher2),KGetStringExit(info.period2),KGetStringExit(info.grade2),
     KGetStringExit(info.subject3),KGetStringExit(info.teacher3),KGetStringExit(info.period3),KGetStringExit(info.grade3),
     KGetStringExit(info.subject4),KGetStringExit(info.teacher4),KGetStringExit(info.period4),KGetStringExit(info.grade4),
     KGetStringExit(info.subject5),KGetStringExit(info.teacher5),KGetStringExit(info.period5),KGetStringExit(info.grade5),
     KGetStringExit(info.subject6),KGetStringExit(info.teacher6),KGetStringExit(info.period6),KGetStringExit(info.grade6),
     KGetStringExit(info.subject7),KGetStringExit(info.teacher7),KGetStringExit(info.period7),KGetStringExit(info.grade7),KGetStringExit(info.stuID)];
    
//    [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE stuName=?",DataBaseName,propertyName],valueStr,KGetStringExit(info.stuName)];
    [db close];
}
//查看数据
+ (NSMutableArray *)getData
{
    
    NSMutableArray *tempArray  = [NSMutableArray arrayWithCapacity:0];
    [db open];
    FMResultSet * set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",DataBaseName]];
    
    while (set.next)
    {
        /*
         stuName TEXT,stuAge TEXT,stuGrade TEXT,subject1 TEXT,teacher1 TEXT,period1 TEXT,subject2 TEXT,teacher2 TEXT,period2 TEXT,subject3 TEXT,teacher3 TEXT,period3 TEXT,subject4 TEXT,teacher4 TEXT,period4 TEXT,subject5 TEXT,teacher5 TEXT,period5 TEXT,subject6 TEXT,teacher6 TEXT,period6 TEXT,subject7 TEXT,teacher7 TEXT,period7 TEXT,
         */
        DataManager *tempModel = [[DataManager alloc] init];
        tempModel.stuName = [set stringForColumn:@"stuName"];
        tempModel.stuAge = [set stringForColumn:@"stuAge"];
        tempModel.stuGrade = [set stringForColumn:@"stuGrade"];
        tempModel.stuRemarks = [set stringForColumn:@"stuRemarks"];
        tempModel.stuID = [set stringForColumn:@"stuID"];
        
        tempModel.subject1 = [set stringForColumn:@"subject1"];
        tempModel.teacher1 = [set stringForColumn:@"teacher1"];
        tempModel.period1 = [set stringForColumn:@"period1"];
        tempModel.grade1 = [set stringForColumn:@"grade1"];
        
        tempModel.subject2 = [set stringForColumn:@"subject2"];
        tempModel.teacher2 = [set stringForColumn:@"teacher2"];
        tempModel.period2 = [set stringForColumn:@"period2"];
        tempModel.grade2 = [set stringForColumn:@"grade2"];
        
        tempModel.subject3 = [set stringForColumn:@"subject3"];
        tempModel.teacher3 = [set stringForColumn:@"teacher3"];
        tempModel.period3 = [set stringForColumn:@"period3"];
        tempModel.grade3 = [set stringForColumn:@"grade3"];
        
        tempModel.subject4 = [set stringForColumn:@"subject4"];
        tempModel.teacher4 = [set stringForColumn:@"teacher4"];
        tempModel.period4 = [set stringForColumn:@"period4"];
        tempModel.grade4 = [set stringForColumn:@"grade4"];
        
        tempModel.subject5 = [set stringForColumn:@"subject5"];
        tempModel.teacher5 = [set stringForColumn:@"teacher5"];
        tempModel.period5 = [set stringForColumn:@"period5"];
        tempModel.grade5 = [set stringForColumn:@"grade5"];
        
        tempModel.subject6 = [set stringForColumn:@"subject6"];
        tempModel.teacher6 = [set stringForColumn:@"teacher6"];
        tempModel.period6 = [set stringForColumn:@"period6"];
        tempModel.grade6 = [set stringForColumn:@"grade6"];
        
        tempModel.subject7 = [set stringForColumn:@"subject7"];
        tempModel.teacher7 = [set stringForColumn:@"teacher7"];
        tempModel.period7 = [set stringForColumn:@"period7"];
        tempModel.grade7 = [set stringForColumn:@"grade7"];
        
        StudentInfoModel *infoModel = [tempModel getInfoModel];
        [tempArray addObject:infoModel];
        
    }
    [set close];
    [db close];
    
    return tempArray;
}

- (StudentInfoModel *)getInfoModel
{
    StudentInfoModel *model = [[StudentInfoModel alloc] init];
    
    model.stuName = self.stuName;
    model.stuAge = self.stuAge;
    model.stuGrade = self.stuGrade;
    model.stuRemarks = self.stuRemarks;
    model.stuID = self.stuID;
    
    NSMutableArray *subjectArray = [NSMutableArray array];
    
    if (!KGetStringIsNIl(self.subject1)) {
        StudentSubject *sub = [[StudentSubject alloc] init];
        sub.subject = self.subject1;
        sub.teacher = self.teacher1;
        sub.period = self.period1;
        sub.grade = self.grade1;
        [subjectArray addObject:sub];
    }
    if (!KGetStringIsNIl(self.subject2)) {
        StudentSubject *sub = [[StudentSubject alloc] init];
        sub.subject = self.subject2;
        sub.teacher = self.teacher2;
        sub.period = self.period2;
        sub.grade = self.grade2;
        [subjectArray addObject:sub];
    }
    if (!KGetStringIsNIl(self.subject3)) {
        StudentSubject *sub = [[StudentSubject alloc] init];
        sub.subject = self.subject3;
        sub.teacher = self.teacher3;
        sub.period = self.period3;
        sub.grade = self.grade3;
        [subjectArray addObject:sub];
    }
    if (!KGetStringIsNIl(self.subject4)) {
        StudentSubject *sub = [[StudentSubject alloc] init];
        sub.subject = self.subject4;
        sub.teacher = self.teacher4;
        sub.period = self.period4;
        sub.grade = self.grade4;
        [subjectArray addObject:sub];
    }
    if (!KGetStringIsNIl(self.subject5)) {
        StudentSubject *sub = [[StudentSubject alloc] init];
        sub.subject = self.subject5;
        sub.teacher = self.teacher5;
        sub.period = self.period5;
        sub.grade = self.grade5;
        [subjectArray addObject:sub];
    }
    if (!KGetStringIsNIl(self.subject6)) {
        StudentSubject *sub = [[StudentSubject alloc] init];
        sub.subject = self.subject6;
        sub.teacher = self.teacher6;
        sub.period = self.period6;
        sub.grade = self.grade6;
        [subjectArray addObject:sub];
    }
    if (!KGetStringIsNIl(self.subject7)) {
        StudentSubject *sub = [[StudentSubject alloc] init];
        sub.subject = self.subject7;
        sub.teacher = self.teacher7;
        sub.period = self.period7;
        sub.grade = self.grade7;
        [subjectArray addObject:sub];
    }
    model.subjectArray = subjectArray;
    return model;
}

+ (instancetype)withModel:(StudentInfoModel *)infoModel
{
    DataManager *model = [[self alloc] init];
    
    model.stuName = infoModel.stuName;
    model.stuAge = infoModel.stuAge;
    model.stuGrade = infoModel.stuGrade;
    model.stuRemarks = infoModel.stuRemarks;
    model.stuID = infoModel.stuID;
    
    for (int i = 0; i <infoModel.subjectArray.count ; i++) {
        StudentSubject *sub = infoModel.subjectArray[i];
        switch (i) {
            case 0:
                model.subject1 = sub.subject;
                model.teacher1 = sub.teacher;
                model.period1 = sub.period;
                model.grade1 = sub.grade;
                break;
                
            case 1:
                
                model.subject2 = sub.subject;
                model.teacher2 = sub.teacher;
                model.period2 = sub.period;
                model.grade2 = sub.grade;
                break;
                
            case 2:
                
                model.subject3 = sub.subject;
                model.teacher3 = sub.teacher;
                model.period3 = sub.period;
                model.grade3 = sub.grade;
                break;
                
            case 3:
                
                model.subject4 = sub.subject;
                model.teacher4 = sub.teacher;
                model.period4 = sub.period;
                model.grade4 = sub.grade;
                break;
                
            case 4:
                
                model.subject5 = sub.subject;
                model.teacher5 = sub.teacher;
                model.period5 = sub.period;
                model.grade5 = sub.grade;
                break;
                
            case 5:
                
                model.subject6 = sub.subject;
                model.teacher6 = sub.teacher;
                model.period6 = sub.period;
                model.grade6 = sub.grade;
                break;
                
            case 6:
                
                model.subject7 = sub.subject;
                model.teacher7 = sub.teacher;
                model.period7 = sub.period;
                model.grade7 = sub.grade;
                break;
            default:
                break;
        }
        
    }
    return model;
}


@end
