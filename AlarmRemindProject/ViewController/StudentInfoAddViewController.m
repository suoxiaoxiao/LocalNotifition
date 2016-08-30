//
//  StudentInfoAddViewController.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/25.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentInfoAddViewController.h"

@interface StudentInfoAddViewController ()

@property (nonatomic ,strong)UIScrollView *scrollView;
/** 学科*/
@property (nonatomic ,strong)UILabel *subjectText;
@property (nonatomic ,strong)UITextField *subjectLabel;
@property (nonatomic ,strong)UIImageView *subjectLine;
/** 学科老师*/
@property (nonatomic ,strong)UILabel *teacherText;
@property (nonatomic ,strong)UITextField *teacherField;
@property (nonatomic ,strong)UIImageView *teacherLine;
/** 学科时段*/
@property (nonatomic ,strong)UILabel *periodText;
@property (nonatomic ,strong)UITextField *periodLabel;
@property (nonatomic ,strong)UIImageView *periodLine;
/**周期*/
@property (nonatomic ,strong)UILabel *cycleText;
@property (nonatomic ,strong)UITextField *cycleLabel;
@property (nonatomic ,strong)UIImageView *cycleLine;
/**班级*/
@property (nonatomic ,strong)UILabel *gradeText;
@property (nonatomic ,strong)UITextField *gradeField;
@property (nonatomic ,strong)UIImageView *gradeLine;


@end

@implementation StudentInfoAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNavi];
    
    [self initUI];
}
- (void)initNavi
{
    self.navigationItem.title = @"新增学员";
    
    UIButton *set = [UIButton buttonWithType:UIButtonTypeCustom];
    [set setTitle:@"保存" forState:0];
    [set setTitleColor:[UIColor blueColor] forState:0];
    set.frame = CGRectMake(0, 0, 40, 40);
    [set addTarget:self action:@selector(handleSaveAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:set];
}

- (void)handleSaveAction
{
    StudentInfoModel *model = [[StudentInfoModel alloc] init];
    model.stuName = self.subjectLabel.text;
    model.stuGrade = self.periodLabel.text;
    model.stuAge = self.teacherField.text;
    model.stuID = [NSString stringWithFormat:@"%00000008ld",[DataManager getData].count];
    model.subjectArray = [NSMutableArray array];
    [DataManager addData:model];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI
{
    CGFloat space = 15;
    CGFloat height = 40;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scrollView];
    
    self.subjectText = [[UILabel alloc] init];
    self.subjectText.font = [UIFont systemFontOfSize:14];
    self.subjectText.textColor = UIColorFromRGB(0x666666, 1.0);
    self.subjectText.text = @"学员名称";
    self.subjectText.frame = CGRectMake(space, 0, 75, height);
    [self.scrollView addSubview:self.subjectText];
    
    self.subjectLabel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.subjectText.frame) + 15, CGRectGetMinY(self.subjectText.frame), WIDTH - 3 * space - 75, height)];
    self.subjectLabel.font = [UIFont systemFontOfSize:14];
    self.subjectLabel.textColor = UIColorFromRGB(0x333333, 1.0);
    self.subjectLabel.placeholder = @"姓名";
    [self.scrollView addSubview:self.subjectLabel];
    
    self.subjectLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.subjectLabel.frame), WIDTH, LineHeight)];
    self.subjectLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.subjectLine];
    
    self.teacherText = [[UILabel alloc] init];
    self.teacherText.font = [UIFont systemFontOfSize:14];
    self.teacherText.textColor = UIColorFromRGB(0x666666, 1.0);
    self.teacherText.text = @"学员姓名";
    self.teacherText.frame = CGRectMake(space, CGRectGetMaxY(self.subjectLine.frame), 75, height);
    [self.scrollView addSubview:self.teacherText];
    
    self.teacherField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.teacherText.frame) + 15, CGRectGetMinY(self.teacherText.frame), WIDTH - 3 * space - 75, height)];
    self.teacherField.font = [UIFont systemFontOfSize:14];
    self.teacherField.textColor = UIColorFromRGB(0x333333, 1.0);
    self.teacherField.placeholder = @"14";
    [self.scrollView addSubview:self.teacherField];
    
    self.teacherLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.teacherField.frame), WIDTH, LineHeight)];
    self.teacherLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.teacherLine];
    
    self.periodText = [[UILabel alloc] init];
    self.periodText.font = [UIFont systemFontOfSize:14];
    self.periodText.textColor = UIColorFromRGB(0x666666, 1.0);
    self.periodText.text = @"学员年级";
    self.periodText.frame = CGRectMake(space, CGRectGetMaxY(self.teacherLine.frame), 75, height);
    [self.scrollView addSubview:self.periodText];
    
    self.periodLabel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.periodText.frame) + 15, CGRectGetMinY(self.periodText.frame), WIDTH - 3 * space - 75, height)];
    self.periodLabel.font = [UIFont systemFontOfSize:14];
    self.periodLabel.textColor = UIColorFromRGB(0x333333, 1.0);
    self.periodLabel.placeholder = @"初中";
    [self.scrollView addSubview:self.periodLabel];
    
    self.periodLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.periodLabel.frame), WIDTH, LineHeight)];
    self.periodLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.periodLine];
    
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView)]];
}
- (void)handleTapView
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
