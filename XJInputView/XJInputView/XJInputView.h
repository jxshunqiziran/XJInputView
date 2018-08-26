//
//  XJInputView.h
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/8.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJFaceEmojeView.h"

#define InputHight 50

#define LINECOLOR [UIColor colorWithHexString:@"#dedede"]

#define maxheight 120

@protocol XJInputViewDelegate<NSObject>

- (void)xjInputViewHeightChanged:(CGFloat)currentHeight;

@end


@interface XJInputView : UIView

@property (nonatomic, copy) void (^faceViewClickBlock)(void);

@property (nonatomic, strong) UIView *parentView;

@property (nonatomic, strong) UITextView *contentTextView;

/*****设置最大行数********/
@property (nonatomic, assign) NSInteger maxLine;

@property (nonatomic, assign) id<XJInputViewDelegate>delegate;

@end
