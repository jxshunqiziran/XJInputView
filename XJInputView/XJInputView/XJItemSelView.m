//
//  XJItemSelView.m
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/21.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJItemSelView.h"
#import "XJInputDefine.h"

@interface XJItemSelView ()<XJInputViewDelegate>
{
    double animationDuration;
    NSNumber *curve;
    publishSelType selType;
    CGRect _keyboardRect;
}

@end

@implementation XJItemSelView

+ (instancetype)showInputViewInView:(UIView*)view itemSelfType:(XJItemSelType)itemSelfType;
{
    
    XJItemSelView *itemSelfView = [[XJItemSelView alloc]initWithFrame:CGRectMake(0, XJScreenHeight, XJScreenWidth, 300)];
    itemSelfView.backgroundColor = [UIColor whiteColor];
    [view addSubview:itemSelfView];
    itemSelfView.itemSelfType = itemSelfType;
    
    switch (itemSelfType) {
            
        case XJItemSelTypeMulitfuntion:
        {
            itemSelfView.xj_top = XJScreenHeight - showSumHeight - 64;
            itemSelfView.mulitFuctionView.parentView = view;
            [itemSelfView addSubview:itemSelfView.mulitFuctionView];
        }
            break;
            
        case XJItemSelTypeInput:
        {
          
            itemSelfView.xj_top = XJScreenHeight - InputHight - 64;
            itemSelfView.inputView.parentView = view;
            itemSelfView.faceEmojeView.textView = itemSelfView.inputView.contentTextView;
            itemSelfView.faceEmojeView.delegate = itemSelfView.inputView;
            [itemSelfView addSubview:itemSelfView.inputView];
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
             self.xj_top =  rect.origin.y - self.inputView.xj_height - 64;
        }
            break;
        case XJItemSelTypeMulitfuntion:{
             self.xj_top =  rect.origin.y - showSumHeight - 64;
        }
            break;
            
        default:
            break;
       
    }
    
    if (type == publishSelTypeFace) {
        
        self.faceEmojeView.xj_top = XJScreenHeight - FaceEmojeViewHeight - 64;
        
    }else{
        
        self.faceEmojeView.xj_top = XJScreenHeight;
    }
    
    [UIView commitAnimations];
}


#pragma mark ---------- 懒加载  -----------

- (XJFaceEmojeView*)faceEmojeView
{
    if (!_faceEmojeView) {
        _faceEmojeView = [[XJFaceEmojeView alloc]initWithFrame:CGRectMake(0, XJScreenHeight-64, XJScreenWidth, FaceEmojeViewHeight)];
        _faceEmojeView.backgroundColor = [UIColor redColor];
    }
    return _faceEmojeView;
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

@end
