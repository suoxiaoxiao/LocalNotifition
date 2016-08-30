//
//  LocalNotificationManager.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/25.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    LocationTypeWeek ,
    LocationTypeDay ,
} LocationType;

@interface LocalNotificationModel : NSObject
/**通知标题*/
@property (nonatomic ,strong)NSString *title;
/**通知时间*/
@property (nonatomic ,strong)NSDate  *notDate;
/**通知标示*/
@property (nonatomic ,strong)NSString *notID;
/** 周期*/
@property (nonatomic , assign)LocationType type;


@end


@interface LocalNotificationManager : NSObject

/**获取所有的通知*/
+ (NSArray *)getAllLocalNotifition;
/**添加一个本地通知*/
+ (void)addLocalNotifitionWith:(LocalNotificationModel *)model;
/**删除一个本地通知*/
+ (void)removeNotifition:(LocalNotificationModel *)model;
/** 删除全部通知*/
+ (void)removeAllLocalNotifications;
/** 通知授权*/
+ (void)authLocalNotifition;

@end
