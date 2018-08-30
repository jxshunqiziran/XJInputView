//
//  XJMulitFuctionView.h
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/21.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define topViewHeight 40 //最上方位置,权限选择高度

#define containerHeight 49 //选项的高度

#define showSumHeight (topViewHeight+containerHeight)

typedef NS_ENUM(NSInteger,publishSelType)
{
    publishSelTypeText, //文本;
    publishSelTypeFace, //表情;
    publishSelTypeAt,   //@;
    publishSelTypePic,  //图片;
    publishSelTypeScope,//选择权限;
    publishSelTypeLocation,//选择位置;
    publishSelTypeOtherItem,//选择位置;
};

@protocol XJItemSelDelegate<NSObject>

- (void) xjFaceEmojeSelType:(publishSelType)type emojeString:(NSString*)emojeString;

- (void)faceViewClickEmojeString:(NSString*)emjeString emojeNamed:(NSString*)emojeNamed isClickDelete:(BOOL)isDelete;

@end

@interface XJMulitFuctionView : UIView

@property (nonatomic,assign) id<XJItemSelDelegate>delegate;

@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, strong) UIButton *secretBtn;

@property (nonatomic, strong) UIButton *faceSelBtn;

@property (nonatomic, copy) void (^faceViewClickBlock)(void);

@end
