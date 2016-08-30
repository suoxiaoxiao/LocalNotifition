//
//  StudentSubjectCell.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/24.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentSubjectCell.h"

@interface StudentSubjectCell ()
/** 学科*/
@property (nonatomic ,strong)UILabel *subjectText;
@property (nonatomic ,strong)UILabel *subjectLabel;
@property (nonatomic ,strong)UIImageView *subjectLine;
/** 学科老师*/
@property (nonatomic ,strong)UILabel *teacherText;
@property (nonatomic ,strong)UILabel *teacherLabel;
@property (nonatomic ,strong)UIImageView *teacherLine;
/** 学科班级*/
@property (nonatomic ,strong)UILabel *gradeText;
@property (nonatomic ,strong)UILabel *gradeLabel;
@property (nonatomic ,strong)UIImageView *gradeLine;
/** 学科时段*/
@property (nonatomic ,strong)UILabel *periodText;
@property (nonatomic ,strong)UILabel *periodLabel;
@property (nonatomic ,strong)UIImageView *periodLine;

@property (nonatomic ,strong)UIImageView *taskView;

@end

@implementation StudentSubjectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.taskView = [[UIImageView alloc] init];
        self.taskView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.5];
        
        [self.contentView addSubview:self.taskView];
        
        self.subjectText = [[UILabel alloc] init];
        self.subjectText.font = [UIFont systemFontOfSize:14];
        self.subjectText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.subjectText.text = @"学科名称";
        self.subjectText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.subjectText];
        
        self.subjectLabel = [[UILabel alloc] init];
        self.subjectLabel.font = [UIFont systemFontOfSize:14];
        self.subjectLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.subjectLabel.text = @"学科名称";
//        self.subjectLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.subjectLabel];
        
        self.teacherText = [[UILabel alloc] init];
        self.teacherText.font = [UIFont systemFontOfSize:14];
        self.teacherText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.teacherText.text = @"学科老师";
        self.teacherText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.teacherText];
        
        self.teacherLabel = [[UILabel alloc] init];
        self.teacherLabel.font = [UIFont systemFontOfSize:14];
        self.teacherLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.teacherLabel.text = @"学科名称";
//        self.teacherLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.teacherLabel];
        
        self.gradeText = [[UILabel alloc] init];
        self.gradeText.font = [UIFont systemFontOfSize:14];
        self.gradeText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.gradeText.text = @"学科班级";
        self.gradeText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.gradeText];
        
        self.gradeLabel = [[UILabel alloc] init];
        self.gradeLabel.font = [UIFont systemFontOfSize:14];
        self.gradeLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.gradeLabel.text = @"学科名称";
//        self.gradeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.gradeLabel];
        
        self.periodText = [[UILabel alloc] init];
        self.periodText.font = [UIFont systemFontOfSize:14];
        self.periodText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.periodText.text = @"学科时段";
        self.periodText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.periodText];
        
        self.periodLabel = [[UILabel alloc] init];
        self.periodLabel.font = [UIFont systemFontOfSize:14];
        self.periodLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.periodLabel.text = @"学科名称";
//        self.periodLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.periodLabel];
        
        self.subjectLine = [[UIImageView alloc] init];
        self.subjectLine.backgroundColor = LineColor;
        [self.contentView addSubview:self.subjectLine];;
        
        
        self.teacherLine = [[UIImageView alloc] init];
        self.teacherLine.backgroundColor = LineColor;
        [self.contentView addSubview:self.teacherLine];;
        
        
        self.gradeLine = [[UIImageView alloc] init];
        self.gradeLine.backgroundColor = LineColor;
        [self.contentView addSubview:self.gradeLine];;
        
        
        self.periodLine = [[UIImageView alloc] init];
        self.periodLine.backgroundColor = LineColor;
        [self.contentView addSubview:self.periodLine];;
        
    }
    return self;
}

- (void)setModel:(StudentSubject *)model
{
    _model = model;
    
    self.subjectLabel.text = model.subject;
    self.teacherLabel.text = model.teacher;
    self.periodLabel.text = [model.period stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.gradeLabel.text = model.grade;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = 15;
    CGFloat height = 35;
    CGFloat width = self.contentView.frame.size.width;
    
    self.taskView.frame = CGRectMake(0, 0, width, height);
    
    self.subjectText.frame = CGRectMake(space, 0, 75, height);
    self.subjectLabel.frame = CGRectMake(CGRectGetMaxX(self.subjectText.frame) + 15, CGRectGetMinY(self.subjectText.frame), width - 3 * space - 75, height);
    self.subjectLine.frame = CGRectMake(0, CGRectGetMaxY(self.subjectText.frame) - LineHeight, width, LineHeight);
    
    self.teacherText.frame = CGRectMake(space, CGRectGetMaxY(self.subjectText.frame), 75, height);
    self.teacherLabel.frame = CGRectMake(CGRectGetMaxX(self.teacherText.frame) + 15, CGRectGetMinY(self.teacherText.frame), width - 3 * space - 75, height);
    self.teacherLine.frame = CGRectMake(0, CGRectGetMaxY(self.teacherText.frame) - LineHeight, width, LineHeight);
    
    self.gradeText.frame = CGRectMake(space, CGRectGetMaxY(self.teacherText.frame), 75, height);
    self.gradeLabel.frame = CGRectMake(CGRectGetMaxX(self.gradeText.frame) + 15, CGRectGetMinY(self.gradeText.frame), width - 3 * space - 75, height);
    self.gradeLine.frame = CGRectMake(0, CGRectGetMaxY(self.gradeText.frame) - LineHeight, width, LineHeight);
    
    self.periodText.frame = CGRectMake(space, CGRectGetMaxY(self.gradeText.frame), 75, height);
    self.periodLabel.frame = CGRectMake(CGRectGetMaxX(self.periodText.frame) + 15, CGRectGetMinY(self.periodText.frame), width - 3 * space - 75, height);
    self.periodLine.frame = CGRectMake(0, CGRectGetMaxY(self.periodText.frame) - LineHeight, width, LineHeight);
    
    
}

@end
