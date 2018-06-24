//
//  ViewController.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/6.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "ViewController.h"
#import "XJNewPublishViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    XJNewPublishViewController *vc = [[XJNewPublishViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
