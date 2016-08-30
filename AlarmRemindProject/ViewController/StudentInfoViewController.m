//
//  StudentInfoViewController.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "StudentInfoViewController.h"
#import "StudentInfoCell.h"
#import "StudentSubjectCell.h"
#import "StudentAddTeacherViewController.h"
#import "StudentInfoFooterView.h"

static NSString *const StudentInfoCellID = @"StudentInfoCellID";
static NSString *const StudentSubjectCellID = @"StudentSubjectCellID";

@interface StudentInfoViewController ()
<UITableViewDelegate, UITableViewDataSource,UITextViewDelegate>
{
    StudentInfoCell *_infoCell;
}

@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)StudentInfoFooterView *footerView;
@property (nonatomic , assign)BOOL isCanEditing;
@end

@implementation StudentInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavi];
    
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
}

- (void)keyBoardChange:(NSNotification *)not
{
    NSLog(@"%@",not.userInfo);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)initNavi
{
    self.isCanEditing = NO;
    self.navigationItem.title = self.model.stuName;
    
    UIButton *set = [UIButton buttonWithType:UIButtonTypeCustom];
    [set setTitle:@"编辑" forState:0];
    [set setTitle:@"完成" forState:UIControlStateSelected];
    [set setTitleColor:[UIColor blueColor] forState:0];
    set.frame = CGRectMake(0, 0, 40, 40);
    [set addTarget:self action:@selector(handleSetAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:set];
}

- (void)handleSetAction:(UIButton *)sender
{
    if (sender.isSelected) { //结束编辑状态
        self.isCanEditing = NO;
        self.model.stuName = _infoCell.nameLabel.text;
        self.model.stuAge = _infoCell.ageLabel.text;
        self.model.stuGrade = _infoCell.gradeLabel.text;
        self.model.stuRemarks = self.footerView.remarksLabel.text;
        sender.selected = !sender.isSelected;
        [DataManager replaceData:self.model];
        [self.footerView remarksLabel].editable = NO;
        [_tableView setEditing:!_tableView.isEditing animated:YES];
        [_tableView reloadData];
        return ;
    }
    
    //开始编辑状体
    sender.selected = !sender.isSelected;
    self.isCanEditing = YES;
    [self.footerView remarksLabel].editable = YES;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
    [_tableView reloadData];
}

- (void)initUI
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionHeaderHeight = 30;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.footerView = [[StudentInfoFooterView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    self.footerView.remarksLabel.delegate = self;
    [self.footerView remarksLabel].editable = NO;
    self.footerView.model = self.model;
    _tableView.tableFooterView = self.footerView;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
        return self.model.subjectArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
         StudentInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:StudentInfoCellID];
        if (!cell) {
            cell = [[StudentInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StudentInfoCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.model;
        [cell canEditing:self.isCanEditing];
        _infoCell = cell;
        return cell;
    }else{
        
        StudentSubjectCell * cell = [tableView dequeueReusableCellWithIdentifier:StudentSubjectCellID];
        if (!cell) {
            cell = [[StudentSubjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StudentSubjectCellID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = self.model.subjectArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 35*3;
    }
    return 35*4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"学员信息";
    }else{
        return @"课程信息";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitle:@"添加课程" forState:0];
        btn.frame = CGRectMake(20, 4, WIDTH - 40, 35);
        [btn addTarget:self action:@selector(handleAddTercher) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [view addSubview:btn];
        
        return view;
    }
    return [[UIView alloc] init];
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 44;
    }
    
    return 0.1;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        
        [self.model.subjectArray  removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [self.tableView   deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}

- (void)handleAddTercher
{
    if (_tableView.isEditing) {
        [self handleSetAction:self.navigationItem.rightBarButtonItem.customView];
    }
    
    StudentAddTeacherViewController *vc = [[StudentAddTeacherViewController alloc] init];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    UIView *touchView = self.footerView;
    CGRect rect = [touchView convertRect:touchView.bounds toView:[[UIApplication sharedApplication].delegate window]];
    if (CGRectGetMaxY(rect) > 315) {
        
        [_tableView setContentInset:UIEdgeInsetsMake(0, 0, CGRectGetMaxY(rect) - 300, 0)];
        
        [_tableView setContentOffset:CGPointMake(0, CGRectGetMaxY(rect) - 315) animated:YES];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
