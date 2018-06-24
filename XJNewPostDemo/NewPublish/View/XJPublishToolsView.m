//
//  XJPublishToolsView.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/6.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJPublishToolsView.h"

@interface XJPublishToolsView()

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIButton *atSelBtn;

@property (nonatomic, strong) UIButton *picSelBtn;

@property (nonatomic, strong) UIView *faceView;

@end

@implementation XJPublishToolsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        
        [self addSubview:self.topView];
        
        [self addSubview:self.containerView];
        
        
    }
    
    return self;
    
}


#pragma -------   lazy View -------

- (UIView*) topView
{
    
    if (!_topView) {
        
       _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XJSCREENWIDTH, 40)];
        _topView.backgroundColor = [UIColor whiteColor];
       [_topView addSubview:self.secretBtn];
       [_topView addSubview:self.retainNumlab];
        
       [self makeConstraints];
        
    }
    return _topView;
    
}


- (UIView*) containerView
{
    
    if (!_containerView) {
        
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, XJSCREENWIDTH, 49)];
        
        [_containerView addSubview:self.faceSelBtn];
        [_containerView addSubview:self.atSelBtn];
        [_containerView addSubview:self.picSelBtn];
        
    }
    return _containerView;
    
}


- (UIButton *)faceSelBtn
{
    if (!_faceSelBtn) {
        
        UIButton *faceSelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        faceSelBtn.frame = CGRectMake(15, 10, 30, 30);
        [faceSelBtn setBackgroundImage:GETIMG(@"IOS会话_表情按钮.png") forState:UIControlStateNormal];
         [faceSelBtn setBackgroundImage:GETIMG(@"btn_keyboard") forState:UIControlStateSelected];
        [faceSelBtn addTarget:self action:@selector(switchEnter) forControlEvents:UIControlEventTouchUpInside];
        _faceSelBtn = faceSelBtn;
        
    }
    
    return _faceSelBtn;
}


- (UIButton *)atSelBtn
{
    if (!_atSelBtn) {
        
        UIButton *faceSelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        faceSelBtn.frame = CGRectMake(80, 10, 30, 30);
        [faceSelBtn setBackgroundImage:GETIMG(@"btn_choose_somebody") forState:UIControlStateNormal];
        [faceSelBtn addTarget:self action:@selector(goAtPerson) forControlEvents:UIControlEventTouchUpInside];
        _atSelBtn = faceSelBtn;
        
    }
    
    return _atSelBtn;
}

- (UIButton *)picSelBtn
{
    if (!_picSelBtn) {
        
        UIButton *faceSelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        faceSelBtn.frame = CGRectMake(145, 10, 30, 30);
        [faceSelBtn setBackgroundImage:GETIMG(@"btn_picture") forState:UIControlStateNormal];
        [faceSelBtn addTarget:self action:@selector(goSelPic) forControlEvents:UIControlEventTouchUpInside];
        _picSelBtn = faceSelBtn;
        
    }
    
    return _picSelBtn;
}


- (UILabel *)retainNumlab
{
    if (!_retainNumlab) {
        
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentRight;
        lab.text = [NSString stringWithFormat:@"%d",MaxContentNum];
        lab.font = GETFONT(15);
        _retainNumlab = lab;
        
    }
    return _retainNumlab;
    
}

- (UIButton *)secretBtn
{
    
    if (!_secretBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithHexString:@"#dedede"];
        [btn setTitle:@"所有人可见" forState:UIControlStateNormal];
        btn.titleLabel.font = GETFONT(14);
        [btn setTitleColor:[UIColor colorWithHexString:@"#537bac"] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [btn setImage:[UIImage imageNamed:@"icon_open"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goScope) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        _secretBtn = btn;
        
    }
    return _secretBtn;
    
}

#pragma mark -----  Private Method ------

- (void)switchEnter
{
   
    self.faceSelBtn.selected = !self.faceSelBtn.selected;
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishToolsTypeSel:)]) {
    
    if (self.faceSelBtn.selected) {
        
         [self.delegate publishToolsTypeSel:publishSelTypeFace];
        
    }else{
        
         [self.delegate publishToolsTypeSel:publishSelTypeText];
    }
        
    }
}

- (void)goAtPerson
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishToolsTypeSel:)]) {
        
        [self.delegate publishToolsTypeSel:publishSelTypeAt];
        
    }
    
}

- (void)goScope
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishToolsTypeSel:)]) {
        
        [self.delegate publishToolsTypeSel:publishSelTypeScope];
        
    }
    
}



- (void)goSelPic
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(publishToolsTypeSel:)]) {
        
        [self.delegate publishToolsTypeSel:publishSelTypePic];
        
    }

}

- (void)setScope:(XJScope *)scope
{
    
    _scope = scope;
    
    [self.secretBtn setTitle:scope.name forState:UIControlStateNormal];
    
    switch (scope.scopeType) {
        case XJNewPublishScopeTypeApart:
        {
            NSMutableString *mutableString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@:",scope.name]];
            for (XJUser*user in scope.selusers) {
                [mutableString appendString:[NSString stringWithFormat:@"%@,",user.name]];
            }
            [self.secretBtn setTitle:[mutableString substringToIndex:mutableString.length-1] forState:UIControlStateNormal];
            [self.secretBtn setImage:[UIImage imageNamed:@"icon_part"] forState:UIControlStateNormal];
        }
            break;
        case XJNewPublishScopeTypeAll:
        {
            [self.secretBtn setImage:[UIImage imageNamed:@"icon_open"] forState:UIControlStateNormal];
        }
            break;
        case XJNewPublishScopeTypeMySelf:
        {
            [self.secretBtn setImage:[UIImage imageNamed:@"icon_secrecy"] forState:UIControlStateNormal];
        }
            break;
        case XJNewPublishScopeTypeSecret:
        {
            NSMutableString *mutableString = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@:",scope.name]];
            for (XJUser*user in scope.selusers) {
                [mutableString appendString:[NSString stringWithFormat:@"%@,",user.name]];
            }
            [self.secretBtn setTitle: [mutableString substringToIndex:mutableString.length-1] forState:UIControlStateNormal];
            [self.secretBtn setImage:[UIImage imageNamed:@"icon_invisible"] forState:UIControlStateNormal];
        }
            break;
        case XJNewPublishScopeTypeFriends:
        {
            [self.secretBtn setImage:[UIImage imageNamed:@"icon_friendVisible"] forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
    CGRect textsize = [self.secretBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.secretBtn.titleLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:GETFONT(14)} context:nil];
    
    CGFloat width =  textsize.size.width+40;
    
    [self.secretBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (width > XJSCREENWIDTH*0.8) {
            
            make.width.mas_equalTo(XJSCREENWIDTH*0.8);
            
        }else{
            
            make.width.mas_equalTo(width);
            
        }
    
    }];
    
}

- (void)makeConstraints
{
    
    [self.secretBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.topView.mas_right).offset(-10);
        make.top.equalTo(self.topView.mas_top).offset(7);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(26);
        
    }];
    
    [self.retainNumlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.secretBtn.mas_left).offset(-10);
        make.top.equalTo(self.topView.mas_top).offset(5);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        
    }];
    
}


@end
