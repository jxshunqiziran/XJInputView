//
//  XJChatInputView.m
//  XJInputView
//
//  Created by 江鑫 on 2018/8/30.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJChatInputView.h"
#import "XJInputDefine.h"

@interface XJChatInputView()<XJFaceEmojeVieDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIButton *faceSelBtn;

@property (nonatomic, strong) UIButton *audioBtn;

@property (nonatomic, strong) UIButton *otherItemBtn;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation XJChatInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.contentTextView];
        [self addSubview:self.faceSelBtn];
        [self addSubview:self.otherItemBtn];
        [self addSubview:self.audioBtn];
        [self addSubview:self.lineView];
        
        [self makeConstraint];
        
    }
    return self;
    
}

- (void)makeConstraint
{
    
    [self.audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.bottom.mas_equalTo(-9);
        make.left.equalTo(self.audioBtn.mas_right).offset(5);
        make.width.mas_equalTo(XJScreenWidth - 120);
    }];
    
    
    [self.faceSelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.contentTextView.mas_right).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.otherItemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-0.6);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(0.6);
    }];
    
}

- (UITextView*)contentTextView
{
    
    if (!_contentTextView) {
        
        UITextView *contentTextView = [[UITextView alloc]init];
        //        contentTextView.placeholderText =  @"请在此评论";
        //        contentTextView.placeholderFont = GETFONT(16);
        //        contentTextView.textColor = contentThemeColor;
        contentTextView.scrollEnabled = NO;
        contentTextView.delegate = self;
        contentTextView.font = GETFONT(16);
        contentTextView.layer.cornerRadius = 5.0;
        contentTextView.layer.masksToBounds = YES;
        contentTextView.backgroundColor = [UIColor whiteColor];
        contentTextView.returnKeyType = UIReturnKeySend;
        contentTextView.layer.borderColor = [LINECOLOR CGColor];
        contentTextView.layer.borderWidth = 0.5;
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = 4;// 字体的行间距
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:paragraphStyle};
        contentTextView.typingAttributes = attributes;
        _contentTextView = contentTextView;
        
    }
    return _contentTextView;
}


- (UIButton *)faceSelBtn
{
    if (!_faceSelBtn) {
        UIButton *faceSelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [faceSelBtn setBackgroundImage:GETIMG(@"btn_expression_default") forState:UIControlStateNormal];
        [faceSelBtn setBackgroundImage:GETIMG(@"btn_keyboard") forState:UIControlStateSelected];
        [faceSelBtn addTarget:self action:@selector(switchEnter) forControlEvents:UIControlEventTouchUpInside];
        _faceSelBtn = faceSelBtn;
    }
    return _faceSelBtn;
}

- (UIButton *)otherItemBtn
{
    if (!_otherItemBtn) {
        UIButton *otherItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [otherItemBtn setBackgroundImage:GETIMG(@"btn_more_default") forState:UIControlStateNormal];
        [otherItemBtn addTarget:self action:@selector(otherItem) forControlEvents:UIControlEventTouchUpInside];
        _otherItemBtn = otherItemBtn;
    }
    return _otherItemBtn;
}

- (UIButton *)audioBtn
{
    if (!_audioBtn) {
        UIButton *audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [audioBtn setBackgroundImage:GETIMG(@"btn_voice") forState:UIControlStateNormal];
        [audioBtn setBackgroundImage:GETIMG(@"btn_voice") forState:UIControlStateSelected];
        [audioBtn addTarget:self action:@selector(switchEnter) forControlEvents:UIControlEventTouchUpInside];
        _audioBtn = audioBtn;
    }
    return _audioBtn;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = XJColor(190, 190, 190);
    }
    return _lineView;
}


#pragma mark  ------  UITextViewDelegate --------


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.otherItemBtn.selected = NO;
    self.faceSelBtn.selected = NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self adjustContentTextViewHeight];
}


/**
 调整文本显示的高度;
 */
- (void) adjustContentTextViewHeight
{
    
    CGSize newSize  = [_contentTextView sizeThatFits:CGSizeMake(XJScreenWidth - 120,MAXFLOAT)];
    NSLog(@"vvv-----%@",NSStringFromCGSize(newSize));
    
    if (newSize.height > maxheight) {
        
        self.xj_height = maxheight;
        _contentTextView.scrollEnabled = YES;
        
    }else{
        
        self.xj_height = newSize.height + 20;
        _contentTextView.scrollEnabled = NO;
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xjChatInputViewHeightChanged:)]) {
        
        [self.delegate xjChatInputViewHeightChanged:self.xj_height];
        
    }
    
}

- (void)switchEnter
{
    
    self.otherItemBtn.selected = NO;
    self.audioBtn.selected = NO;
    _faceSelBtn.selected = !_faceSelBtn.selected;
    
    if (_faceSelBtn.selected) {
        [self.contentTextView endEditing:YES];
        self.faceViewClickBlock();
    }else{
        [self.contentTextView becomeFirstResponder];
    }
    
}

- (void)otherItem
{
    self.faceSelBtn.selected = NO;
    self.audioBtn.selected = NO;
    self.otherItemBtn.selected = !self.otherItemBtn.selected;
    
    
    if (_otherItemBtn.selected) {
        [self.contentTextView endEditing:YES];
        self.faceViewClickBlock();
    }else{
        [self.contentTextView becomeFirstResponder];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xjOtherItembuttoClick)]) {
        
        [self.delegate xjOtherItembuttoClick];
        
    }
}
@end
