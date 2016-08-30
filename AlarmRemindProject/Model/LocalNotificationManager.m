//
//  LocalNotificationManager.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/25.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "LocalNotificationManager.h"
#import "Appdelegate.h"


@implementation LocalNotificationModel



@end

@implementation LocalNotificationManager


+ (void)authLocalNotifition
{
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types ==UIUserNotificationTypeNone){
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
}

/**获取所有的通知*/
+ (NSArray *)getAllLocalNotifition
{
    return [[UIApplication sharedApplication] scheduledLocalNotifications];
}
/**添加一个本地通知*/
+ (void)addLocalNotifitionWith:(LocalNotificationModel *)model
{
    //kCFCalendarUnitWeekday一周一次
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSLog(@"fireDate=%@",model.notDate);
    notification.fireDate = model.notDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔      NSWeekCalendarUnit
    notification.repeatInterval =  NSWeekCalendarUnit;//一周一次
    notification.repeatCalendar = [NSCalendar currentCalendar];
    
    notification.alertBody =  model.title;
    notification.applicationIconBadgeNumber += 1;
    notification.alertAction = @"查看";
    notification.hasAction = YES;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:model.notID forKey:@"id"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
}

/**删除一个本地通知*/
+ (void)removeNotifition:(LocalNotificationModel *)model
{
    //取消某一个通知
    NSArray *notificaitons = [self getAllLocalNotifition];
    //获取当前所有的本地通知
    if (!notificaitons || notificaitons.count <= 0) {
        return;
    }
    for (UILocalNotification *notify in notificaitons) {
        if ([[notify.userInfo objectForKey:@"id"] isEqualToString:model.notID]) {
            //取消一个特定的通知
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
            break;
        }
    }
}
/**删除全部通知*/
+ (void)removeAllLocalNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

}

@end
