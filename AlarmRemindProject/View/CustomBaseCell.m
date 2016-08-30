//
//  CustomBaseCell.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/26.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "CustomBaseCell.h"

@interface CustomBaseCell ()


@property (nonatomic ,strong)UILabel *subjectText;
@property (nonatomic ,strong)UILabel *subjectLabel;
@property (nonatomic ,strong)UIImageView *subjectLine;

@end

@implementation CustomBaseCell

- (instancetype)initWithText:(NSString *)text Title:(NSString *)title
{
    if (self = [super init]) {
        
        self.subjectText = [[UILabel alloc] init];
        self.subjectText.font = [UIFont systemFontOfSize:14];
        self.subjectText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.subjectText.text = text;
        self.subjectText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.subjectText];
        
        self.subjectLabel = [[UILabel alloc] init];
        self.subjectLabel.font = [UIFont systemFontOfSize:14];
        self.subjectLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.subjectLabel.text = [title stringByReplacingOccurrencesOfString:@"-" withString:@" "];
        [self addSubview:self.subjectLabel];
        
        self.subjectLine = [[UIImageView alloc] init];
        self.subjectLine.backgroundColor = LineColor;
        [self addSubview:self.subjectLine];;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = 15;
    CGFloat height = 35;
    CGFloat width = self.frame.size.width;
    
    self.subjectText.frame = CGRectMake(space, 0, 70, height);
    self.subjectLabel.frame = CGRectMake(CGRectGetMaxX(self.subjectText.frame) + 15, CGRectGetMinY(self.subjectText.frame), width - 3 * space - 70, height);
    self.subjectLine.frame = CGRectMake(0, CGRectGetMaxY(self.subjectText.frame) - LineHeight, width, LineHeight);
}

@end
