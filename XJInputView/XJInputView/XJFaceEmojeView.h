//
//  XJFaceEmojeView.h
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/7.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FaceEmojeViewHeight 220  //表情面板总高度

#define BottomBarHeight 40  //底部选项条高度;

#define EmojeWH 30 //表情宽高;

@interface XJFaceButton : UIButton

@property (nonatomic, assign) BOOL isDleted;

@property (nonatomic, strong) NSIndexPath* indexPath;

@property (nonatomic, strong) NSString *emjeNamed;

@property (nonatomic, strong) NSString *emjeString;

@end


@protocol XJFaceEmojeVieDelegate<NSObject>

@optional
- (void)faceViewClickEmojeString:(NSString*)emjeString emojeNamed:(NSString*)emojeNamed isClickDelete:(BOOL)isDelete;

- (void)faceViewClickHeightChanged;

- (void)faceViewSendBtnClick;

@end

@interface XJFaceEmojeView : UIView

@property (nonatomic, assign) id<XJFaceEmojeVieDelegate>delegate;

@property (nonatomic, strong) UITextView *textView;

@end
