//
//  XJChatInputView.h
//  XJInputView
//
//  Created by 江鑫 on 2018/8/30.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJFaceEmojeView.h"

#define LINECOLOR [UIColor colorWithHexString:@"#dedede"]

#define maxheight 120

@protocol XJChatInputViewDelegate<NSObject>

- (void)xjChatInputViewHeightChanged:(CGFloat)currentHeight;

- (void)xjOtherItembuttoClick;

@end

@interface XJChatInputView : UIView

@property (nonatomic, copy) void (^faceViewClickBlock)(void);

@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, assign) id<XJChatInputViewDelegate>delegate;

/*****设置最大行数********/
@property (nonatomic, assign) NSInteger maxLine;

@end
