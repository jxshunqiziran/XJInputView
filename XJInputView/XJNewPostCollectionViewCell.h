//
//  XJNewPostCollectionViewCell.h
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/17.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJNewPostCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UIImageView *picImgeView;

@property (nonatomic, copy) void(^deleteBtnClickBlock)(NSInteger index);

@end
