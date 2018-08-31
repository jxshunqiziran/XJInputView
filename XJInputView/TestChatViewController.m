//
//  TestChatViewController.m
//  XJInputView
//
//  Created by 江鑫 on 2018/8/30.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "TestChatViewController.h"
#import "XJItemSelView.h"
#import "XJToolBarScrollView.h"

@interface TestChatViewController ()
{
    XJItemSelView*inputView;
}

@property (nonatomic,strong)XJToolBarScrollView *toolBarScrollView;

@end

@implementation TestChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"聊天界面";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    inputView = [XJItemSelView showInputViewInView:self.view itemSelfType:XJItemSelTypeChat contentTextView:nil];
    inputView.chatBarCustomView = self.toolBarScrollView;
    
}

- (XJToolBarScrollView*)toolBarScrollView
{
    if (!_toolBarScrollView) {
        _toolBarScrollView = [[XJToolBarScrollView alloc]initWithFrame:inputView.toobarView.bounds];
        _toolBarScrollView.pagingEnabled = YES;
        _toolBarScrollView.bounces = NO;
        _toolBarScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _toolBarScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
