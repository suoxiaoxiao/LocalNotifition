//
//  StudentInfoCell.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/24.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentInfoCell.h"

@interface StudentInfoCell ()<UITextFieldDelegate>

@property (nonatomic ,strong)UILabel *nameText;
@property (nonatomic ,strong)UIImageView *nameLine;
@property (nonatomic ,strong)UILabel *ageText;
@property (nonatomic ,strong)UIImageView *ageLine;
@property (nonatomic ,strong)UILabel *gradeText;
@property (nonatomic ,strong)UIImageView *gradeLine;

@property (nonatomic ,strong)UIImageView *line;
@property (nonatomic ,strong)UIImageView *topLine;

@end

@implementation StudentInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameText = [[UILabel alloc] init];
        self.nameText.font = [UIFont systemFontOfSize:14];
        self.nameText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.nameText.text = @"学员名称";
        self.nameText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.nameText];
        
        self.nameLabel = [[UITextField alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.nameLabel.text = @"张小三";
        self.nameLabel.delegate = self;
        [self.contentView addSubview:self.nameLabel];
        
        self.ageText = [[UILabel alloc] init];
        self.ageText.font = [UIFont systemFontOfSize:14];
        self.ageText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.ageText.text = @"学员年龄";
        self.ageText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.ageText];
        
        self.ageLabel = [[UITextField alloc] init];
        self.ageLabel.font = [UIFont systemFontOfSize:14];
        self.ageLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.ageLabel.text = @"14";
        self.ageLabel.delegate = self;
        [self.contentView addSubview:self.ageLabel];
        
        self.gradeText = [[UILabel alloc] init];
        self.gradeText.font = [UIFont systemFontOfSize:14];
        self.gradeText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.gradeText.text = @"学员年级";
        self.gradeText.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.gradeText];
        
        self.gradeLabel = [[UITextField alloc] init];
        self.gradeLabel.font = [UIFont systemFontOfSize:14];
        self.gradeLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.gradeLabel.text = @"小六";
        self.gradeLabel.delegate = self;
        [self.contentView addSubview:self.gradeLabel];
        
        self.nameLine = [[UIImageView alloc] init];
        self.nameLine.backgroundColor = LineColor;
        [self.contentView addSubview:self.nameLine];
        
        self.ageLine = [[UIImageView alloc] init];
        self.ageLine.backgroundColor = LineColor;
        [self.contentView addSubview:self.ageLine];
        
        self.gradeLine = [[UIImageView alloc] init];
        self.gradeLine.backgroundColor = LineColor;
        [self.contentView addSubview:self.gradeLine];
        
    }
    return self;
}

- (void)setModel:(StudentInfoModel *)model
{
    _model = model;
    
    self.nameLabel.text = model.stuName;
    self.ageLabel.text = model.stuAge;
    self.gradeLabel.text = model.stuGrade;
    
}

- (void)canEditing:(BOOL)editing
{
    self.nameLabel.enabled = editing;
    self.ageLabel.enabled = editing;
    self.gradeLabel.enabled = editing;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.nameLabel) {
        self.nameLabel.text = textField.text;
    }else if(textField == self.ageLabel) {
        self.ageLabel.text = textField.text;
    }else if(textField == self.gradeLabel){
        self.gradeLabel.text = textField.text;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat space = 15;
    CGFloat height = 35;
    CGFloat width = self.contentView.frame.size.width;
    
    self.nameText.frame = CGRectMake(space, 0, 75, height);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.nameText.frame) + 15, 0, width - 3 * space - 75, height);
    
    self.ageText.frame = CGRectMake(space, CGRectGetMaxY(self.nameText.frame), 75, height);
    self.ageLabel.frame = CGRectMake(CGRectGetMaxX(self.ageText.frame) + 15, CGRectGetMaxY(self.nameText.frame), width - 3 * space - 75, height);
    
    self.gradeText.frame = CGRectMake(space, CGRectGetMaxY(self.ageText.frame), 75, height);
    self.gradeLabel.frame = CGRectMake(CGRectGetMaxX(self.ageText.frame) + 15, CGRectGetMaxY(self.ageText.frame), width - 3 * space - 75, height);
    
    
    self.nameLine.frame = CGRectMake(0, CGRectGetMaxY(self.nameText.frame)-LineHeight, width, LineHeight);
    self.ageLine.frame = CGRectMake(0, CGRectGetMaxY(self.ageText.frame) - LineHeight, width, LineHeight);
    self.gradeLine.frame = CGRectMake(0, CGRectGetMaxY(self.gradeText.frame) - LineHeight, width, LineHeight);
    
}

@end
