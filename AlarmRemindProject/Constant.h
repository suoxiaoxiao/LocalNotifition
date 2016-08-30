//
//  Constant.h
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#import "DataManager.h"


#define UIColorFromRGB(rgbValue,alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define LineColor UIColorFromRGB(0xd9d9d9, 1.0)
#define LineHeight (1/2.0f)

#define DataBaseName @"studentInfo"

#define KGetStringIsNIl(str) (str==nil||[str isEqualToString:@""]||[str isKindOfClass:[NSNull class]])?YES:NO
//给字符串负值防止奔溃
#define KGetStringExit(token)   (token==nil||[token isKindOfClass:[NSNull class]])?@"":[NSString stringWithFormat:@"%@",token]





#endif /* Constant_h */
