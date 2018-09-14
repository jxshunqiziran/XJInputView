//
//  XJItemSelView.m
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/21.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJItemSelView.h"
#import "XJInputDefine.h"


@interface XJItemSelView ()<XJInputViewDelegate,XJChatInputViewDelegate>
{
    double animationDuration;
    NSNumber *curve;
    publishSelType selType;
    CGRect _keyboardRect;
}


@end

@implementation XJItemSelView

+ (instancetype)showInputViewInView:(UIView*)view itemSelfType:(XJItemSelType)itemSelfType contentTextView:(UITextView*)contentTextView;
{
    
    XJItemSelView *itemSelfView = [[XJItemSelView alloc]initWithFrame:CGRectMake(0, XJScreenHeight, XJScreenWidth, 300)];
    [view addSubview:itemSelfView];
    itemSelfView.itemSelfType = itemSelfType;
    
    switch (itemSelfType) {
            
        case XJItemSelTypeMulitfuntion:
        {
            itemSelfView.xj_top = XJScreenHeight - showSumHeight - 64;
            itemSelfView.faceEmojeView.textView = contentTextView;
            itemSelfView.mulitFuctionView.contentTextView = contentTextView;
            [itemSelfView addSubview:itemSelfView.mulitFuctionView];
        }
            break;
            
        case XJItemSelTypeInput:
        {
            itemSelfView.xj_top = XJScreenHeight - InputHight - NavigationHeight;
            itemSelfView.faceEmojeView.textView = itemSelfView.inputView.contentTextView;
            itemSelfView.faceEmojeView.delegate = itemSelfView.inputView;
            [itemSelfView addSubview:itemSelfView.inputView];
        }
            break;
            
            
        case XJItemSelTypeChat:
        {
            itemSelfView.xj_top = XJScreenHeight - InputHight - NavigationHeight;
            itemSelfView.faceEmojeView.textView = itemSelfView.chatInputView.contentTextView;

            [itemSelfView addSubview:itemSelfView.chatInputView];
            [view addSubview:itemSelfView.toobarView];
        }
            break;
        default:
            break;
    }
   
    [view addSubview:itemSelfView.faceEmojeView];
    
    return itemSelfView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
        [self addNotification];
        
    }
    return self;
    
}

- (void)addNotification
{
    
    [NoTiCenter addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [NoTiCenter addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


#pragma mark -------  keyboard Notification ------

// 键盘将要出现:
- (void)keyBoardWillShow:(NSNotification *)notification
{
    
    [self getKeyBoardInformation:notification];
    
    selType = publishSelTypeText;
    
    _keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self adjustPublishToolsViewFrame:_keyboardRect publishSelType:publishSelTypeText];
    
}

//键盘将要消失:
- (void)keyBoardWillHide:(NSNotification *)notification
{
     selType = publishSelTypeFace;
    
    [self getKeyBoardInformation:notification];
    
    [self adjustPublishToolsViewFrame:CGRectMake(0, XJScreenHeight, 0, 0) publishSelType:publishSelTypeText];
}

- (void)getKeyBoardInformation:(NSNotification*)notification
{
    
    animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];

    curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
}

- (void) adjustPublishToolsViewFrame:(CGRect)rect publishSelType:(publishSelType)type;
{
    //动画改变frame:
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration?animationDuration:0.25f];
    [UIView setAnimationCurve:[curve intValue]];
    
    switch (self.itemSelfType) {
        case XJItemSelTypeInput:{
             self.xj_top =  rect.origin.y - self.inputView.xj_height - NavigationHeight;
        }
            break;
        case XJItemSelTypeMulitfuntion:{
             self.xj_top =  rect.origin.y - showSumHeight - NavigationHeight;
        }
            break;
        case XJItemSelTypeChat:{
             self.xj_top =  rect.origin.y - self.chatInputView.xj_height - NavigationHeight;
        }
            break;
            
        default:
            break;
       
    }
    
    switch (type) {
        case publishSelTypeFace:
        {
            self.faceEmojeView.xj_top = XJScreenHeight - FaceEmojeViewHeight - NavigationHeight;
             self.toobarView.xj_top = XJScreenHeight;
        }
            break;
        case publishSelTypeText:
        {
            self.faceEmojeView.xj_top = XJScreenHeight;
            self.toobarView.xj_top = XJScreenHeight;
        }
            break;
        case publishSelTypeOtherItem:
        {
            self.faceEmojeView.xj_top = XJScreenHeight;
            self.toobarView.xj_top = XJScreenHeight - FaceEmojeViewHeight - NavigationHeight;
        }
            break;
        default:
            break;
    }
    
    [UIView commitAnimations];
}


#pragma mark ---------- 懒加载  -----------

- (XJFaceEmojeView*)faceEmojeView
{
    if (!_faceEmojeView) {
        _faceEmojeView = [[XJFaceEmojeView alloc]initWithFrame:CGRectMake(0, XJScreenHeight, XJScreenWidth, FaceEmojeViewHeight)];
        _faceEmojeView.backgroundColor = [UIColor redColor];
    }
    return _faceEmojeView;
}

- (XJToolBarView*)toobarView
{
    if (!_toobarView) {
        _toobarView = [[XJToolBarView alloc]initWithFrame:CGRectMake(0, XJScreenHeight-NavigationHeight, XJScreenWidth, FaceEmojeViewHeight)];
        _toobarView.backgroundColor = [UIColor redColor];
    }
    return _toobarView;
}

- (XJMulitFuctionView*)mulitFuctionView
{
    if (!_mulitFuctionView) {
        _mulitFuctionView = [[XJMulitFuctionView alloc]initWithFrame:CGRectMake(0, 0, XJScreenWidth, showSumHeight)];
        WeakSelf(weakSelf);
        _mulitFuctionView.faceViewClickBlock = ^{
            [weakSelf adjustPublishToolsViewFrame:CGRectMake(0, XJScreenHeight-FaceEmojeViewHeight, XJScreenWidth, XJScreenHeight) publishSelType:publishSelTypeFace];
        };
    }
    return _mulitFuctionView;
}

- (XJInputView*)inputView
{
    if (!_inputView) {
        _inputView = [[XJInputView alloc]initWithFrame:CGRectMake(0, 0, XJScreenWidth, InputHight)];
        _inputView.delegate = self;
        WeakSelf(weakSelf);
        _inputView.faceViewClickBlock = ^{
            [weakSelf adjustPublishToolsViewFrame:CGRectMake(0, XJScreenHeight-FaceEmojeViewHeight, XJScreenWidth, XJScreenHeight) publishSelType:publishSelTypeFace];
        };
    }
    return _inputView;
}

- (XJChatInputView*)chatInputView
{
    if (!_chatInputView) {
        _chatInputView = [[XJChatInputView alloc]initWithFrame:CGRectMake(0, 0, XJScreenWidth, InputHight)];
        _chatInputView.delegate = self;
        WeakSelf(weakSelf);
        _chatInputView.faceViewClickBlock = ^{
            [weakSelf adjustPublishToolsViewFrame:CGRectMake(0, XJScreenHeight-FaceEmojeViewHeight, XJScreenWidth, XJScreenHeight) publishSelType:publishSelTypeFace];
        };
    }
    return _chatInputView;
}

- (void) setChatBarCustomView:(UIView *)chatBarCustomView
{
    
    [self.toobarView addSubview:chatBarCustomView];
    chatBarCustomView.frame = self.toobarView.bounds;
    
}

#pragma mark ------  XJInputViewDelegate ------

- (void)xjInputViewHeightChanged:(CGFloat)currentHeight
{
    switch (selType) {
        case publishSelTypeFace:{
        [self adjustPublishToolsViewFrame:CGRectMake(0, XJScreenHeight-FaceEmojeViewHeight, XJScreenWidth, XJScreenHeight) publishSelType:publishSelTypeFace];
    }
            break;
        case publishSelTypeText:{
            [self adjustPublishToolsViewFrame:_keyboardRect publishSelType:publishSelTypeText];
        }
            break;
            
        default:
            break;
    }

}

#pragma mark ------  XJInputViewDelegate ------
- (void)xjChatInputViewHeightChanged:(CGFloat)currentHeight
{
    switch (selType) {
        case publishSelTypeFace:{
            [self adjustPublishToolsViewFrame:CGRectMake(0, XJScreenHeight-FaceEmojeViewHeight, XJScreenWidth, XJScreenHeight) publishSelType:publishSelTypeFace];
        }
            break;
        case publishSelTypeText:{
            [self adjustPublishToolsViewFrame:_keyboardRect publishSelType:publishSelTypeText];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)xjOtherItembuttoClick;
{
     [self adjustPublishToolsViewFrame:CGRectMake(0, XJScreenHeight-FaceEmojeViewHeight, XJScreenWidth, XJScreenHeight) publishSelType:publishSelTypeOtherItem];
}
@end
