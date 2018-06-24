//
//  XJCollectionViewCell.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/25.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, copy) void(^deleteBtnClickBlock)(NSInteger index);

- (void)setPicImageView:(UIImage*)image;

@end
