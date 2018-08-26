//
//  XJItemSelView.h
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/21.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJFaceEmojeView.h"
#import "XJMulitFuctionView.h"
#import "XJInputView.h"

typedef NS_ENUM(NSInteger,XJItemSelType){
    XJItemSelTypeInput,          //输入框类型;
    XJItemSelTypeMulitfuntion,   //功能选择类型;
    XJItemSelTypeMulitCustom,    //自定义类型;
};

@interface XJItemSelView : UIView

@property (nonatomic, strong) XJFaceEmojeView *faceEmojeView;

@property (nonatomic, strong) XJMulitFuctionView *mulitFuctionView;

@property (nonatomic, strong) XJInputView *inputView;

@property (nonatomic, assign) XJItemSelType itemSelfType;

+ (instancetype)showInputViewInView:(UIView*)view itemSelfType:(XJItemSelType)itemSelfType;

@end
