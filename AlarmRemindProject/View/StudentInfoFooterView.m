//
//  StudentInfoFooterView.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/24.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentInfoFooterView.h"

@interface StudentInfoFooterView ()

@property (nonatomic ,strong)UILabel *remarksText;

@property (nonatomic ,strong)UIImageView *line;

@end

@implementation StudentInfoFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.remarksText = [[UILabel alloc] init];
        self.remarksText.font = [UIFont systemFontOfSize:14];
        self.remarksText.textColor = UIColorFromRGB(0x666666, 1.0);
        self.remarksText.text = @"学员备注";
        [self addSubview:self.remarksText];
        
        self.remarksLabel = [[UITextView alloc] init];
        self.remarksLabel.font = [UIFont systemFontOfSize:14];
        self.remarksLabel.textColor = UIColorFromRGB(0x333333, 1.0);
//        self.remarksLabel.numberOfLines = 0;
        self.remarksLabel.text = @"暂无";
        [self addSubview:self.remarksLabel];
        
        self.line = [[UIImageView alloc] init];
        self.line.backgroundColor = LineColor;
        [self addSubview:self.line];
    }
    return self;
}

- (void)setModel:(StudentInfoModel *)model
{
    _model = model;
    self.remarksLabel.text = model.stuRemarks;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat space = 15;
    self.remarksText.frame = CGRectMake(10, 0, 75, 35);
    
    CGRect titleF = [self.remarksLabel.text boundingRectWithSize:CGSizeMake(WIDTH - 3 * space - 75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil];
    
    self.remarksLabel.frame = CGRectMake(CGRectGetMaxX(self.remarksText.frame) + space, 10, WIDTH - 3 * space - 75, titleF.size.height > 35 ?titleF.size.height : 35);
    self.line.frame = CGRectMake(0, CGRectGetMaxY(self.remarksLabel.frame) + 10, WIDTH, LineHeight);
}

@end
