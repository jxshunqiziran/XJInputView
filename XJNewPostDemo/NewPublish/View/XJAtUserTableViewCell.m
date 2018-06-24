//
//  XJAtUserTableViewCell.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJAtUserTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation XJAtUserTableViewCell

- (void) setScopeuser:(XJUser *)scopeuser
{
    
    _scopeuser = scopeuser;
    
    self.Namelab.text = scopeuser.name;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:scopeuser.picURL]];
    
    if (scopeuser.isSelected) {
        
       self.selImageView.image = GETIMG(@"icon_Selected");
        
    }else{
        
        self.selImageView.image = GETIMG(@"icon_choose_default");
        
    }
}


- (void)setUser:(XJUser *)user
{
    
    _user = user;
    
    self.Namelab.text = user.name;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:user.picURL]];
    
    
}

-(UILabel*)Namelab
{
    if (!_Namelab) {
        UILabel*lab = [[UILabel alloc]init];
        lab.font = GETFONT(14);
        lab.textColor = [UIColor blackColor];
        [self.contentView addSubview:lab];
        _Namelab = lab;
    }
    return _Namelab;
}


-(UIImageView*)avatarImageView
{
    if (!_avatarImageView) {
        UIImageView*imageView = [[UIImageView alloc]init];
        imageView.layer.cornerRadius = 18;
        imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:imageView];
        _avatarImageView = imageView;
    }
    return _avatarImageView;
}

-(UIImageView*)selImageView
{
    if (!_selImageView) {
        UIImageView*imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        _selImageView = imageView;
    }
    return _selImageView;
}



-(void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    CGFloat H = self.frame.size.height;
    
    //1,cell展示背景图;
    CGFloat BackImageViewX = 15;
    CGFloat BackImageViewY = (H-35)/2;
    CGFloat BackImageViewW = 36;
    CGFloat BackImageViewH = 36;
    self.avatarImageView.frame = CGRectMake(BackImageViewX, BackImageViewY, BackImageViewW, BackImageViewH);
    
    //1,人名;
    CGFloat SrcX = CGRectGetMaxX(self.avatarImageView.frame)+10;
    CGFloat SrcY = 0;
    CGFloat SrcW = 80;
    CGFloat SrcH = H;
    self.Namelab.frame = CGRectMake(SrcX, SrcY, SrcW, SrcH);
    
    
    CGFloat selImageViewX = XJSCREENWIDTH - 38;
    CGFloat selImageViewY = (H-18)/2;
    CGFloat selImageViewW = 18;
    CGFloat selImageViewH = 18;
    self.selImageView.frame = CGRectMake(selImageViewX, selImageViewY, selImageViewW, selImageViewH);
    
}

@end
