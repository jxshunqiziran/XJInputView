//
//  ViewController.m
//  XJInputView
//
//  Created by 江鑫 on 2018/8/24.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "ViewController.h"
#import "XJNewPostViewController.h"
#import "TestCommentViewController.h"
#import "TestChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton*newPostbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newPostbtn.frame = CGRectMake(100, 100, 100, 40);
    [newPostbtn setTitle:@"发布界面" forState:UIControlStateNormal];
    newPostbtn.backgroundColor = [UIColor redColor];
    [newPostbtn addTarget:self action:@selector(newPost) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newPostbtn];
    
    UIButton*commentbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentbtn.frame = CGRectMake(100, 200, 100, 40);
    [commentbtn setTitle:@"评论界面" forState:UIControlStateNormal];
    commentbtn.backgroundColor = [UIColor redColor];
    [commentbtn addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commentbtn];
    
    
    UIButton*chatbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chatbtn.frame = CGRectMake(100, 300, 100, 40);
    [chatbtn setTitle:@"聊天界面" forState:UIControlStateNormal];
    chatbtn.backgroundColor = [UIColor redColor];
    [chatbtn addTarget:self action:@selector(chat) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chatbtn];
}

- (void)comment
{
    TestCommentViewController *VC = [[TestCommentViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)newPost
{
    XJNewPostViewController *VC = [[XJNewPostViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)chat
{
    TestChatViewController *VC = [[TestChatViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
