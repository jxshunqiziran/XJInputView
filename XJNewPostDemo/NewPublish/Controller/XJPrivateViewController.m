//
//  XJPrivateViewController.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJPrivateViewController.h"
#import "XJAtUserTableViewCell.h"


@interface XJPrivateViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger selSeciton;
}

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NSString *resueIder = @"cell";

@implementation XJPrivateViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择公开范围";
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
    [self setupNav];
    
}

- (void)setupNav
{
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    commitBtn.frame = CGRectMake(0, 0, 50, 16);
    commitBtn.titleLabel.font = GETFONT(15);
    [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(chooseScope) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:commitBtn];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_btn_backEST"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
}

- (void) chooseScope
{
    
    XJScope *scope = self.dataArray[selSeciton];
    
    NSMutableArray*tempArray = [NSMutableArray arrayWithCapacity:0];
    for (XJUser*user in scope.users) {
        if (user.isSelected) {
            [tempArray addObject:user];
        }
    }
    scope.selusers = tempArray;
    self.chooseScopeBlock(scope);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void) back
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 模拟数据:
 */
- (void) loadData
{
    for ( int i = 0; i < 5; i++) {
        
        XJScope *scope = [[XJScope alloc]init];
        if (i == 0) {
            scope.name = @"所有人可见";
            scope.scopeType = XJNewPublishScopeTypeAll;
        }
        if (i == 1) {
            scope.name = @"自己可见";
            scope.scopeType = XJNewPublishScopeTypeMySelf;
        }
        if (i == 2) {
           scope.name = @"好友可见";
           scope.scopeType = XJNewPublishScopeTypeFriends;
        }
        if (i == 3) {
            scope.name = @"可见好友";
            scope.users = [self constructUsers];
            scope.scopeType = XJNewPublishScopeTypeApart;
        }
        if (i == 4) {
            scope.name = @"不可见好友";
            scope.users = [self constructUsers];
            scope.scopeType = XJNewPublishScopeTypeSecret;
        }
        [self.dataArray addObject:scope];
        
    }
    
    [self.tableView reloadData];
    
    
}

-(UITableView*)tableView
{
    if (!_tableView) {
        UITableView*tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, XJSCREENWIDTH, XJSCREENHEIGHT) style:UITableViewStyleGrouped];
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tableView.tableFooterView = [UIView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 60;
        [tableView registerClass:[XJAtUserTableViewCell class] forCellReuseIdentifier:resueIder];
        _tableView = tableView;
    }
    return _tableView;
}

-(NSMutableArray*)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XJSCREENWIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = section;
    UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selScope:)];
    [view addGestureRecognizer:tap];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, XJSCREENWIDTH-100, 40)];
    lable.backgroundColor = [UIColor whiteColor];
    lable.font = GETFONT(15);
    XJScope *scope = self.dataArray[section];
    lable.text = scope.name;
    [view addSubview:lable];
    
    return view;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    XJScope *scope = self.dataArray[section];
    NSMutableArray *array = scope.users;
    return scope.isCover?array.count:0;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XJAtUserTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:resueIder forIndexPath:indexPath];
    XJScope *scope = self.dataArray[indexPath.section];
    cell.scopeuser = scope.users[indexPath.row];
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    XJScope *scope = self.dataArray[indexPath.section];
    XJUser*user = scope.users[indexPath.row];
    user.isSelected = !user.isSelected;
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40.0f;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}


- (void) selScope:(UIGestureRecognizer*)tap
{
    
    UIView *view = tap.view;
    XJScope *scope = self.dataArray[view.tag];
    selSeciton = view.tag;
    
    if (scope.scopeType == XJNewPublishScopeTypeSecret||scope.scopeType == XJNewPublishScopeTypeApart) {
        
        scope.isCover = !scope.isCover;
        [self.tableView reloadData];
        
    }else{
        
        self.chooseScopeBlock(scope);
        [self.navigationController popViewControllerAnimated:YES];
        
    }

    
}


- (NSMutableArray*)constructUsers
{
    
    NSMutableArray *usersArray = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableArray*nameArray = [NSMutableArray arrayWithObjects:@"张三",@"老江",@"老学",@"老蒋",@"老鹏",@"老浩",@"老胜",@"老明", nil];
    
    NSMutableArray*ideArray = [NSMutableArray arrayWithObjects:@"26",@"09",@"47",@"23",@"18",@"16",@"34",@"12", nil];
    
    NSMutableArray*picURLArray = [NSMutableArray arrayWithObjects:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=800526113,964745870&fm=111&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1588071102,531204233&fm=111&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2013202952,4124926300&fm=111&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1663128811,3476118487&fm=111&gp=0.jpg",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3556292106,3090002995&fm=111&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2914775197,2190061372&fm=111&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3390921584,2152725882&fm=111&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2833406439,1292822921&fm=111&gp=0.jpg", nil];
    
    for (int i = 0; i < nameArray.count; i++) {
        
        XJUser *user = [[XJUser alloc]init];
        user.name = nameArray[i];
        user.userId = ideArray[i];
        user.picURL = picURLArray[i];
        [usersArray addObject:user];
        
    }
    
    return usersArray;
    
}

@end
