//
//  StudentAddTeacherViewController.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/24.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentAddTeacherViewController.h"

static NSInteger const periodTag = (10001);
static NSInteger const cycleTag = (10002);
static NSInteger const gradeTag = (10003);

@interface StudentAddTeacherViewController ()
<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *_minuteArray;
    NSMutableArray *_hourArray;
    NSMutableArray *_weekArray;
    NSMutableArray *_gradeArray;
}

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

@implementation StudentAddTeacherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createData];
    
    [self initNavi];
    
    [self initUI];
    
    [self.subjectLabel becomeFirstResponder];
}

- (void)createData
{
    _minuteArray = [NSMutableArray arrayWithCapacity:60];
    _hourArray = [NSMutableArray arrayWithCapacity:24];
    
    for (int i = 0; i < 60; i++) {
        
        [_minuteArray addObject:[NSString stringWithFormat:@"%02d分",i]];
        
        if (i < 24) {
            [_hourArray addObject:[NSString stringWithFormat:@"%d时",i]];
        }
    }
    
    _weekArray = [NSMutableArray arrayWithCapacity:7];
    [_weekArray addObjectsFromArray:@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]];
    _gradeArray = [NSMutableArray arrayWithArray:@[@"1V1",@"1V3"]];
}

- (void)initNavi
{
    self.navigationItem.title = self.model.stuName;
    
    UIButton *set = [UIButton buttonWithType:UIButtonTypeCustom];
    [set setTitle:@"保存" forState:0];
    [set setTitleColor:[UIColor blueColor] forState:0];
    set.frame = CGRectMake(0, 0, 40, 40);
    [set addTarget:self action:@selector(handleSaveAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:set];
}

- (void)handleSaveAction
{
        if (KGetStringIsNIl(self.teacherField.text) || KGetStringIsNIl(self.periodLabel.text) || KGetStringIsNIl(self.gradeField.text) || KGetStringIsNIl(self.cycleLabel.text) || KGetStringIsNIl(self.subjectLabel.text)) {
        [[[UIAlertView alloc] initWithTitle:@"不能有空选项" message:@"" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        return ;
    }
    
    [self.view endEditing:YES];
    
    StudentSubject *model = [[StudentSubject alloc] init];
    model.subject = self.subjectLabel.text;
    model.period = [NSString stringWithFormat:@"%@-%@",self.cycleLabel.text,self.periodLabel.text];
    model.teacher = self.teacherField.text;
    model.grade = self.gradeField.text;
    [self.model.subjectArray addObject:model];
    [DataManager replaceData:self.model];
    
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
    self.subjectText.text = @"学科名称";
    self.subjectText.frame = CGRectMake(space, 0, 75, height);
    [self.scrollView addSubview:self.subjectText];
    
    self.subjectLabel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.subjectText.frame) + 15, CGRectGetMinY(self.subjectText.frame), WIDTH - 3 * space - 75, height)];
    self.subjectLabel.font = [UIFont systemFontOfSize:14];
    self.subjectLabel.textColor = UIColorFromRGB(0x333333, 1.0);
    self.subjectLabel.placeholder = @"eg.数学";
    [self.scrollView addSubview:self.subjectLabel];
    
    self.subjectLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.subjectLabel.frame), WIDTH, LineHeight)];
    self.subjectLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.subjectLine];
    
    self.teacherText = [[UILabel alloc] init];
    self.teacherText.font = [UIFont systemFontOfSize:14];
    self.teacherText.textColor = UIColorFromRGB(0x666666, 1.0);
    self.teacherText.text = @"学科老师";
    self.teacherText.frame = CGRectMake(space, CGRectGetMaxY(self.subjectLine.frame), 75, height);
    [self.scrollView addSubview:self.teacherText];
    
    self.teacherField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.teacherText.frame) + 15, CGRectGetMinY(self.teacherText.frame), WIDTH - 3 * space - 75, height)];
    self.teacherField.font = [UIFont systemFontOfSize:14];
    self.teacherField.textColor = UIColorFromRGB(0x333333, 1.0);
    self.teacherField.placeholder = @"老师名";
    [self.scrollView addSubview:self.teacherField];
    
    self.teacherLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.teacherField.frame), WIDTH, LineHeight)];
    self.teacherLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.teacherLine];
    
    self.periodText = [[UILabel alloc] init];
    self.periodText.font = [UIFont systemFontOfSize:14];
    self.periodText.textColor = UIColorFromRGB(0x666666, 1.0);
    self.periodText.text = @"学科时段";
    self.periodText.frame = CGRectMake(space, CGRectGetMaxY(self.teacherLine.frame), 75, height);
    [self.scrollView addSubview:self.periodText];
    
    self.periodLabel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.periodText.frame) + 15, CGRectGetMinY(self.periodText.frame), WIDTH - 3 * space - 75, height)];
    self.periodLabel.font = [UIFont systemFontOfSize:14];
    self.periodLabel.textColor = UIColorFromRGB(0x333333, 1.0);
    self.periodLabel.placeholder = @"10:00~12:00";
    
    UIView *input = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:input.bounds];
    [input addSubview:pickView];
    pickView.dataSource = self;
    pickView.delegate = self;
    pickView.tag = periodTag;
    pickView.showsSelectionIndicator = YES;
    [pickView selectRow:_hourArray.count/2 inComponent:0 animated:YES];
    [pickView selectRow:_minuteArray.count/2 inComponent:1 animated:YES];
    [pickView selectRow:_hourArray.count/2 inComponent:2 animated:YES];
    [pickView selectRow:_minuteArray.count/2 inComponent:3 animated:YES];
    [self pickerView:pickView didSelectRow:_hourArray.count/2 inComponent:0];
    [self pickerView:pickView didSelectRow:_minuteArray.count/2 inComponent:1];
    [self pickerView:pickView didSelectRow:_hourArray.count/2 inComponent:2];
    [self pickerView:pickView didSelectRow:_minuteArray.count/2 inComponent:3];
    self.periodLabel.inputView = input;
    
    [self.scrollView addSubview:self.periodLabel];
    
    self.periodLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.periodLabel.frame), WIDTH, LineHeight)];
    self.periodLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.periodLine];
    
    self.cycleText = [[UILabel alloc] init];
    self.cycleText.font = [UIFont systemFontOfSize:14];
    self.cycleText.textColor = UIColorFromRGB(0x666666, 1.0);
    self.cycleText.text = @"学科周期";
    self.cycleText.frame = CGRectMake(space, CGRectGetMaxY(self.periodLine.frame), 75, height);
    [self.scrollView addSubview:self.cycleText];
    
    self.cycleLabel = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.cycleText.frame) + 15, CGRectGetMinY(self.cycleText.frame), WIDTH - 3 * space - 75, height)];
    self.cycleLabel.font = [UIFont systemFontOfSize:14];
    self.cycleLabel.textColor = UIColorFromRGB(0x333333, 1.0);
    self.cycleLabel.placeholder = @"周六";
    [self.scrollView addSubview:self.cycleLabel];
    
    UIView *input1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    UIPickerView *pickView1 = [[UIPickerView alloc] initWithFrame:input1.bounds];
    [input1 addSubview:pickView1];
    pickView1.dataSource = self;
    pickView1.delegate = self;
    pickView1.tag = cycleTag;
    [self pickerView:pickView1 didSelectRow:0 inComponent:0];
    self.cycleLabel.inputView = input1;
    
    self.cycleLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.cycleLabel.frame), WIDTH, LineHeight)];
    self.cycleLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.cycleLine];
    
    self.gradeText = [[UILabel alloc] init];
    self.gradeText.font = [UIFont systemFontOfSize:14];
    self.gradeText.textColor = UIColorFromRGB(0x666666, 1.0);
    self.gradeText.text = @"学科班级";
    self.gradeText.frame = CGRectMake(space, CGRectGetMaxY(self.cycleLine.frame), 75, height);
    [self.scrollView addSubview:self.gradeText];
    
    self.gradeField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.gradeText.frame) + 15, CGRectGetMinY(self.gradeText.frame), WIDTH - 3 * space - 75, height)];
    self.gradeField.font = [UIFont systemFontOfSize:14];
    self.gradeField.textColor = UIColorFromRGB(0x333333, 1.0);
    self.gradeField.placeholder = @"1V1";
    UIView *input3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    UIPickerView *pickView3 = [[UIPickerView alloc] initWithFrame:input3.bounds];
    [input3 addSubview:pickView3];
    pickView3.dataSource = self;
    pickView3.delegate = self;
    pickView3.tag = gradeTag;
    [self pickerView:pickView3 didSelectRow:0 inComponent:0];
    self.gradeField.inputView = input3;
    
    [self.scrollView addSubview:self.gradeField];
    
    self.gradeLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.gradeField.frame), WIDTH, LineHeight)];
    self.gradeLine.backgroundColor = LineColor;
    [self.scrollView addSubview:self.gradeLine];
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView)]];
}

- (void)handleTapView
{
    [self.view endEditing:YES];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    if (pickerView.tag == periodTag) {
        return 4;
    }else if (pickerView.tag == cycleTag) {
        return 1;
    }else if (pickerView.tag == gradeTag) {
        return 1;
    }
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    if (pickerView.tag == periodTag) {
        
        if (component == 0 || component == 2) {
            return _hourArray.count;
        }
        return _minuteArray.count;
    }else if (pickerView.tag == cycleTag) {
        
        return _weekArray.count;
        
    }else if (pickerView.tag == gradeTag) {
        return _gradeArray.count;
    }
    
//    if (pickerView.tag == 4) {
//        
//        if (component == 0 || component == 2) {
//            return _hourArray.count;
//        }
//        return _minuteArray.count;
//    }
    return 0;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (pickerView.tag == periodTag) {
        if (component == 0 || component == 2) {
            return _hourArray[row];
        }
        return _minuteArray[row];
    }else if (pickerView.tag == cycleTag) {
        
        return _weekArray[row];
        
    }else if (pickerView.tag == gradeTag) {
        
        return _gradeArray[row];
    }
    
//    if (pickerView.tag == 4) {
//        if (component == 0 || component == 2) {
//            return _hourArray[row];
//        }
//        return _minuteArray[row];
//    }
    return @"";
}

NSString *startHour;
NSString *endHour;
NSString *startMin;
NSString *endMin;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == periodTag) {
        
        switch (component + 1) {
            case 1:
                startHour = _hourArray[row];
                break;
                
            case 2:
                startMin = _minuteArray[row];
                break;
            case 3:
                endHour = _hourArray[row];
                break;
            case 4:
                endMin = _minuteArray[row];
                break;
            default:
                break;
        }
        
        self.periodLabel.text = [NSString stringWithFormat:@"%@%@~%@%@",KGetStringExit(startHour),KGetStringExit(startMin),KGetStringExit(endHour),KGetStringExit(endMin)];
        return ;
        
    }else if (pickerView.tag == cycleTag) {
        
        self.cycleLabel.text = _weekArray[row];
        
        return ;
        
    }else if (pickerView.tag == gradeTag) {
        
        self.gradeField.text = _gradeArray[row];
        
        return ;
    }
    
    
}

- (void)dealloc
{
    startHour = nil;
    startMin = nil;
    endHour = nil;
    endMin = nil;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 35;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
