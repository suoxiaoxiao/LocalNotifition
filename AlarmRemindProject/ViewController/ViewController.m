//
//  ViewController.m
//  AlarmRemindProject
//
//  Created by 索晓晓 on 16/8/23.
//  Copyright © 2016年 SXiao.RR. All rights reserved.
//

#import "ViewController.h"
#import "SetViewController.h"
#import "StudentListCell.h"
#import "StudentInfoViewController.h"
#import "StudentInfoAddViewController.h"


static NSString *const StudentListCellID = @"StudentListCellID";

@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    BOOL         _isShowSection1;
    BOOL         _isShowSection2;
}
@property (nonatomic ,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavi];
    
    [self createTableView];
    
    [self reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadData];
}

- (void)reloadData
{
    self.dataArray = [DataManager getData];
    
    NSMutableArray *section1 = [NSMutableArray array];
    NSMutableArray *section2 = [NSMutableArray array];
    
    for (StudentInfoModel *sub in self.dataArray) {
        
        if (sub.subjectArray.count == 0) {
            [section1 addObject:sub];
            continue;
        }
        
        for (StudentSubject *subInfo in sub.subjectArray) {
            
            if ([subInfo.grade containsString:@"1V1"]) {
                [section1 addObject:sub];
                break;
            }
            if ([subInfo.grade containsString:@"1V3"]) {
                
                [section2 addObject:sub];
                break;
            }
        }
    }
    
    self.dataArray = [NSMutableArray arrayWithObjects:section1,section2,nil];
    
    [_tableView reloadData];
}

- (void)initNavi
{
    self.navigationItem.title = @"学生列表";
    UIButton *set = [UIButton buttonWithType:UIButtonTypeCustom];
    [set setImage:[UIImage imageNamed:@"set"] forState:0];
    set.frame = CGRectMake(0, 0, 40, 40);
    [set addTarget:self action:@selector(handleSetAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:set];
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    [add setTitle:@"新增" forState:0];
    [add setTitleColor:[UIColor orangeColor] forState:0];
    add.frame = CGRectMake(0, 0, 40, 40);
    [add addTarget:self action:@selector(handleAddAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:add];
    
    UIButton *edit = [UIButton buttonWithType:UIButtonTypeCustom];
    [edit setTitle:@"编辑" forState:0];
    [edit setTitle:@"完成" forState:UIControlStateSelected];
    [edit setTitleColor:[UIColor orangeColor] forState:0];
    edit.frame = CGRectMake(0, 0, 40, 40);
    [edit addTarget:self action:@selector(handleeditAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:set],[[UIBarButtonItem alloc] initWithCustomView:edit]];
    
    _isShowSection1 = NO;
    _isShowSection2 = NO;
    
}

- (void)handleSetAction
{
    SetViewController *vc = [[SetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleeditAction:(UIButton *)sender
{
    _isShowSection1 = YES;
    _isShowSection2 = YES;
    
    sender.selected = !sender.isSelected;
    [_tableView setEditing:!_tableView.isEditing animated:YES];
    [self reloadData];
    
}

- (void)handleAddAction
{
    StudentInfoAddViewController *vc = [[StudentInfoAddViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *section1 = self.dataArray[section];
    
    if ((section == 0 && _isShowSection1) || (section == 1 && _isShowSection2)) {
        return  [section1 count];
    }else{
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentListCell *cell = [tableView dequeueReusableCellWithIdentifier:StudentListCellID];
    if (!cell) {
        cell = [[StudentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:StudentListCellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.row == 0) {
        [cell showTopLine];
    }else [cell hideTopLine];
    
    StudentInfoModel *model = self.dataArray[indexPath.section][indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentInfoModel *model = self.dataArray[indexPath.section][indexPath.row];
    
    return 35 + 35 * model.subjectArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    
    head.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, WIDTH - 15, 44)];
    
    label.textColor = [UIColor blackColor];
    
    label.text = @"1V1";
    if (section == 1)label.text = @"1V3";
    
    [head addSubview:label];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44-LineHeight, WIDTH, LineHeight)];
    line.backgroundColor = LineColor;
    [head addSubview:line];
    
    head.tag = 1000 + section;
    
    [head addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleShowSection:)]];
    
    return head;
}

- (void)handleShowSection:(UIGestureRecognizer *)ges
{
    UIView *gesView = ges.view;
    if (gesView.tag == 1000) {//第一组
        _isShowSection1 = !_isShowSection1;
    }else{//第二组
        _isShowSection2 = !_isShowSection2;
    }
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentInfoViewController *vc = [[StudentInfoViewController alloc] init];
    vc.model = self.dataArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        [DataManager deleteData:self.dataArray[indexPath.section][indexPath.row]];
        [self.dataArray[indexPath.section]  removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [_tableView   deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
