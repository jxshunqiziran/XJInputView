//
//  XJMulitFuctionView.m
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/21.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJMulitFuctionView.h"
#import "XJInputDefine.h"

@interface XJMulitFuctionView ()

@property (nonatomic, strong) UIButton *picSelBtn;

@property (nonatomic, strong) UIButton *atSelBtn;

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIView *containerView;

@end

@implementation XJMulitFuctionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.topView];
        [self addSubview:self.containerView];
        [self setupLayerLineView];
        
    }
    return self;
    
}

- (void)setupLayerLineView
{
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, self.xj_height-0.6,XJScreenWidth, 0.6);
    layer.backgroundColor = XJColor(190, 190, 190).CGColor;
    [self.layer addSublayer:layer];
}

- (UIView*)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, topViewHeight, XJScreenWidth, containerHeight)];
        _containerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_containerView addSubview:self.faceSelBtn];
        [_containerView addSubview:self.atSelBtn];
        [_containerView addSubview:self.picSelBtn];
    }
    return _containerView;
}

- (UIView*) topView
{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XJScreenWidth, topViewHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:self.secretBtn];
    }
    return _topView;
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

- (void) goAtPerson
{
    [self.contentTextView endEditing:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xjFaceEmojeSelType:emojeString:)]) {
        
        [self.delegate xjFaceEmojeSelType:publishSelTypeAt emojeString:nil];
        
    }
    
}

- (void) goSelPic
{
    
    [self.contentTextView endEditing:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xjFaceEmojeSelType:emojeString:)]) {
        
        [self.delegate xjFaceEmojeSelType:publishSelTypePic emojeString:nil];
        
    }
    
}

- (void)switchEnter
{
    
    _faceSelBtn.selected = !_faceSelBtn.selected;
    
    if (_faceSelBtn.selected) {
        
        [self.contentTextView endEditing:YES];
        self.faceViewClickBlock();
       
    }else{
        
        [self.contentTextView becomeFirstResponder];

    }
}
@end
