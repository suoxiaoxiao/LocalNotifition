//
//  StudentListCell.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentListCell.h"
#import "CustomBaseCell.h"

@interface StudentListCell ()



@property (nonatomic ,strong)UILabel *nameLabel;
@property (nonatomic ,strong)UIImageView *line;
@property (nonatomic ,strong)UIImageView *topLine;
@property (nonatomic ,strong)UIView *subjectView;

//@property (nonatomic ,strong)UILabel *subjectText;
//@property (nonatomic ,strong)UILabel *subjectLabel;
//@property (nonatomic ,strong)UIImageView *subjectLine;




@end

@implementation StudentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        self.nameLabel.text = @"呵呵呵";
        
        [self.contentView addSubview:self.nameLabel];
        
        self.subjectView = [[UIView alloc] init];
        
        [self.contentView addSubview:self.subjectView];
        
        self.line = [[UIImageView alloc] init];
        self.line.backgroundColor = LineColor;
        [self.contentView addSubview:self.line];
        
        self.topLine = [[UIImageView alloc] init];
        self.topLine.backgroundColor = LineColor;
        self.topLine.hidden = YES;
        [self.contentView addSubview:self.topLine];
    }
    return self;
}

- (void)setModel:(StudentInfoModel *)model
{
    _model = model;
    self.nameLabel.text = model.stuName;
    
    [self.subjectView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (StudentSubject *subModel in model.subjectArray) {
        
        CustomBaseCell *cell = [[CustomBaseCell alloc] initWithText:subModel.subject Title:subModel.period];
        [self.subjectView addSubview:cell];
        
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
}

- (void)showTopLine
{
    self.topLine.hidden = NO;
}
- (void)hideTopLine
{
    self.topLine.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nameLabel.frame = CGRectMake(15, 0, WIDTH - 15, 35- LineHeight);
    
    CGFloat cellY = 0;
    for (int i = 0; i < self.subjectView.subviews.count; i++) {
        
        CustomBaseCell *cell = self.subjectView.subviews[i];
        
        cell.frame = CGRectMake(0, cellY, self.contentView.frame.size.width, 35);
        
        cellY+= 35;
    }
    self.subjectView.frame = CGRectMake(0, 35, self.contentView.frame.size.width, self.model.subjectArray.count * 35);
    
    self.line.frame = CGRectMake(0, self.contentView.frame.size.height - LineHeight, WIDTH, LineHeight);
    
    self.topLine.frame = CGRectMake(0, 0, WIDTH, LineHeight);
}

@end
