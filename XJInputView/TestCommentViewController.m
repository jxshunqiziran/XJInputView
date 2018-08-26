//
//  TestCommentViewController.m
//  XJInputView
//
//  Created by 江鑫 on 2018/8/24.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "TestCommentViewController.h"
#import "XJItemSelView.h"
@interface TestCommentViewController ()

@end

@implementation TestCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    XJItemSelView*inputView = [XJItemSelView showInputViewInView:self.view itemSelfType:XJItemSelTypeInput];
    
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
