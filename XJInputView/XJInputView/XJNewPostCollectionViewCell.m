//
//  XJNewPostCollectionViewCell.m
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/17.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJNewPostCollectionViewCell.h"
#import "XJInputDefine.h"
@interface XJNewPostCollectionViewCell ()

@end


@implementation XJNewPostCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
    
}

- (void)setupView
{
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [self.contentView addSubview:imageView];
    imageView.frame = self.contentView.bounds;
    imageView.contentMode =  UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    _picImgeView = imageView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = self.contentView.bounds;
    btn.frame = CGRectMake(CGRectGetMaxX(frame)-15, -5, 20, 20);
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [btn setBackgroundImage:GETIMG(@"btn_delete") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickToDeletePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    _deleteBtn = btn;
    
}

- (void)clickToDeletePicture:(UIButton*)sender
{
    self.deleteBtnClickBlock(self.index);
}
@end
