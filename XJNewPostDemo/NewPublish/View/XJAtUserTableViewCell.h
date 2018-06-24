//
//  XJAtUserTableViewCell.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJUser.h"

@interface XJAtUserTableViewCell : UITableViewCell

@property (nonatomic,strong) XJUser *user;
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UIImageView *selImageView;
@property (nonatomic,strong) UILabel *Namelab;

@property (nonatomic,strong) XJUser *scopeuser;



@end
