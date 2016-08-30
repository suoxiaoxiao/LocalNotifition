//
//  StudentInfoModel.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentInfoModel.h"
#import "LocalNotificationManager.h"

@implementation StudentSubject

@end

@implementation StudentInfoModel
//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
- (void)localNotifition
{
//    NSString *title = [NSString stringWithFormat:@"%@",self.stuName];
    
    for (StudentSubject *sub in self.subjectArray) {
        
        if (KGetStringIsNIl(sub.teacher) || KGetStringIsNIl(sub.subject) || KGetStringIsNIl(sub.period)) {
            
            continue;
        }
        
        NSLog(@"%@",sub.period);
        NSArray *perArr = [sub.period componentsSeparatedByString:@"-"];
        
        NSInteger perWeek = [self getWeekNum:perArr.firstObject];
        
        NSArray *times = [perArr.lastObject componentsSeparatedByString:@"~"];
        NSString *startTime = [times.firstObject stringByReplacingOccurrencesOfString:@"时" withString:@":"];
        startTime = [startTime stringByReplacingOccurrencesOfString:@"分" withString:@""];
        startTime = [startTime stringByAppendingString:@":00"];
//        周三-12时30分~14时30分
        NSInteger todayWeekNum = [self todayWeek];
        //计算几天后是周几
        NSDate *startDate;
        if (todayWeekNum > perWeek) { //过了 4 > 3
            //+ 7 - (4 -3)
            startDate = [self lastDayOf:7-(todayWeekNum - perWeek)];
            
        }else if(todayWeekNum < perWeek){//还没到
            
            startDate = [self lastDayOf:perWeek - todayWeekNum];
            
        }else{//相等 
            
            startDate = [NSDate date];
            
        }
        
        NSString *startStr = [self getStringOfDate:startDate];
        startStr = [startStr stringByAppendingString:startTime];
        
        NSLog(@"%@",startStr);
        startDate = [self getDateOfString:startStr];
        
        
        LocalNotificationModel *notModel = [[LocalNotificationModel alloc] init];
        notModel.title = [NSString stringWithFormat:@"%@ %@在%@上课",self.stuName,perArr.lastObject,sub.grade];
        notModel.notDate = startDate;
        notModel.notID = self.stuID;
        notModel.type = LocationTypeWeek;
        [LocalNotificationManager addLocalNotifitionWith:notModel];
    }
    
}

- (NSInteger)getWeekNum:(NSString *)week
{
    if ([week isEqualToString:@"周一"]) {
        return 1;
    }else if ([week isEqualToString:@"周二"]) {
        return 2;
    }else if ([week isEqualToString:@"周三"]) {
        return 3;
    }else if ([week isEqualToString:@"周四"]) {
        return 4;
    }else if ([week isEqualToString:@"周五"]) {
        return 5;
    }else if ([week isEqualToString:@"周六"]) {
        return 6;
    }else if ([week isEqualToString:@"周日"]) {
        return 7;
    }
    return 0;
}

- (NSDate *)getDateOfString:(NSString *)dateStr
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    [fmt setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [fmt dateFromString:dateStr];
}

- (NSString *)getStringOfDate:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd ";
    return [fmt stringFromDate:date];
}

- (NSInteger)todayWeek
{
    NSDate *date = [NSDate date];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:components];
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    
    NSInteger week = [weekdayComponents weekday];
    
    
    if (week == 1) {
        week = 7;
    }else{
        week -= 1;
    }
    
    return week;//1.Mon. 2.Thes. 3.Wed. 4.Thur. 5.Fri. 6.Sat. 7.Sun.
}

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)lastDayOf:(NSInteger)num{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = +num;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    return newDate;
}

//- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    
//    [calendar setFirstWeekday:2];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
//    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    [comp setDay:1];
//    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
//    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
//    return firstWeekday;
//}

@end
