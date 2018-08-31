//
//  XJToolBarScrollView.m
//  XJInputView
//
//  Created by 江鑫 on 2018/8/31.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJToolBarScrollView.h"
#import "XJInputDefine.h"

@implementation XJToolBarItem

@end

@interface XJToolBarScrollView()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation XJToolBarScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self configToolData];
        [self setupView];
        
    }
    return self;
    
}

- (void)setupView
{
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        XJToolBarItem *item = self.dataArray[i];
        
        CGFloat btnW = (XJScreenWidth-20)/4;
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10+i%4*btnW + i/8*(XJScreenWidth), i/4*110-i/8*220, btnW, 110)];
        [self addSubview:bgView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 8;
        btn.layer.borderColor = XJColor(200, 200, 200).CGColor;
        [btn setImage:GETIMG(item.imageNamed)  forState:UIControlStateNormal];
        btn.frame = CGRectMake((btnW-60)/2, 20, 60, 60);
        [bgView addSubview:btn];
        
        UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+5, btnW, 20)];
        titlelab.text = item.title;
        titlelab.textColor = XJColor(140, 140, 140);
        titlelab.textAlignment = NSTextAlignmentCenter;
        titlelab.font = GETFONT(12);
        [bgView addSubview:titlelab];
        
    }
    self.contentSize = CGSizeMake(XJScreenWidth*((self.dataArray.count/8)+1), 220);
    
}

- (void)configToolData
{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    NSArray *titleArray = @[@"照片",@"拍摄",@"语音通话",@"位置",@"红包",@"语音输入",@"个人名片",@"收藏",@"文件",@"卡券"];
    NSArray *imageArray = @[@"sharemore_pic",@"sharemore_video",@"sharemore_multitalk",@"sharemore_location",@"sharemore_pic",@"sharemore_voiceinput",@"sharemore_friendcard",@"sharemore_myfav",@"sharemore_files",@"sharemorePay"];
    for (int i = 0; i < titleArray.count; i++) {
        XJToolBarItem *item = [[XJToolBarItem alloc]init];
        item.title = titleArray[i];
        item.index = i;
        item.imageNamed = imageArray[i];
        [self.dataArray addObject:item];
    }
}

@end
