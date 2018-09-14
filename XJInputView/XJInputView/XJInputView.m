//
//  XJInputView.m
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/8.
//  Copyright © 2018年 XJ. All rights reserved.
//
//1,placehoder待添加;

#import "XJInputView.h"
#import "XJInputDefine.h"

@interface XJInputView()<XJFaceEmojeVieDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIButton *faceSelBtn;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation XJInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.contentTextView];
        [self addSubview:self.faceSelBtn];
        [self addSubview:self.lineView];
        
        [self makeConstraint];
        
    }
    return self;
    
}

- (void)makeConstraint
{
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(9);
        make.bottom.mas_equalTo(-9);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(XJScreenWidth - 50);
    }];
    
    [self.faceSelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
        [faceSelBtn setBackgroundImage:GETIMG(@"IOS会话_表情按钮.png") forState:UIControlStateNormal];
        [faceSelBtn setBackgroundImage:GETIMG(@"btn_keyboard") forState:UIControlStateSelected];
        [faceSelBtn addTarget:self action:@selector(switchEnter) forControlEvents:UIControlEventTouchUpInside];
        _faceSelBtn = faceSelBtn;
    }
    return _faceSelBtn;
}

- (UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = XJColor(190, 190, 190);
    }
    return _lineView;
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

#pragma mark  ------  UITextViewDelegate --------


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.faceSelBtn.selected = NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self adjustContentTextViewHeight];
}

#pragma mark ------- XJFaceEmojeVieDelegate ----

- (void)faceViewClickHeightChanged
{
    [self adjustContentTextViewHeight];
}

/**
 调整文本显示的高度;
 */
- (void) adjustContentTextViewHeight
{
    
    CGSize newSize  = [_contentTextView sizeThatFits:CGSizeMake(XJScreenWidth - 50,MAXFLOAT)];
    NSLog(@"vvv-----%@",NSStringFromCGSize(newSize));
    
    if (newSize.height > maxheight) {
        
        self.xj_height = maxheight;
        _contentTextView.scrollEnabled = YES;
        
    }else{
        
        self.xj_height = newSize.height + 20;
        _contentTextView.scrollEnabled = NO;
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(xjInputViewHeightChanged:)]) {
    
        [self.delegate xjInputViewHeightChanged:self.xj_height];
        
    }
    
}
@end
