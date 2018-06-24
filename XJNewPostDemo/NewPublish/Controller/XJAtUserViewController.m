//
//  XJAtUserViewController.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJAtUserViewController.h"
#import "XJUser.h"
#import "XJAtUserTableViewCell.h"

@interface XJAtUserViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NSString *resueId = @"cell";

@implementation XJAtUserViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择@的人";
    
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
}


/**
 模拟数据:
 */
- (void)loadData
{
    NSMutableArray*nameArray = [NSMutableArray arrayWithObjects:@"张三",@"老江",@"老学",@"老蒋",@"老鹏",@"老浩",@"老胜",@"老明", nil];
    
    NSMutableArray*ideArray = [NSMutableArray arrayWithObjects:@"26",@"09",@"47",@"23",@"18",@"16",@"34",@"12", nil];
    
    NSMutableArray*picURLArray = [NSMutableArray arrayWithObjects:@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=800526113,964745870&fm=111&gp=0.jpg",@"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1588071102,531204233&fm=111&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2013202952,4124926300&fm=111&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1663128811,3476118487&fm=111&gp=0.jpg",@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3556292106,3090002995&fm=111&gp=0.jpg",@"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2914775197,2190061372&fm=111&gp=0.jpg",@"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3390921584,2152725882&fm=111&gp=0.jpg",@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2833406439,1292822921&fm=111&gp=0.jpg", nil];
    
    for (int i = 0; i < nameArray.count; i++) {
        
        XJUser *user = [[XJUser alloc]init];
        user.name = nameArray[i];
        user.userId = ideArray[i];
        user.picURL = picURLArray[i];
        [self.dataArray addObject:user];
        
    }
    
    [self.tableView reloadData];
    
}

-(UITableView*)tableView
{
    if (!_tableView) {
        UITableView*tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, XJSCREENWIDTH, XJSCREENHEIGHT) style:UITableViewStylePlain];
        tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tableView.tableFooterView = [UIView new];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 60;
        [tableView registerClass:[XJAtUserTableViewCell class] forCellReuseIdentifier:resueId];
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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XJAtUserTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:resueId forIndexPath:indexPath];
    XJUser*user = self.dataArray[indexPath.row];
    cell.user = user;
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    XJUser*user = self.dataArray[indexPath.row];
    
    self.chooseUserBlock(user);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
