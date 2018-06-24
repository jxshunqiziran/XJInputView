//
//  XJPublishToolsView.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/6.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJScope.h"
#import "XJUser.h"

#define MaxContentNum 1024 //允许输入的最大字符数量

typedef NS_ENUM(NSInteger,publishSelType)
{
    publishSelTypeFace,
    publishSelTypeText,
    publishSelTypeAt,
    publishSelTypePic,
    publishSelTypeScope,
};

@protocol PublishToolsSelDelegate<NSObject>

- (void) publishToolsTypeSel:(publishSelType)type;

@end

@interface XJPublishToolsView : UIView

@property (nonatomic, strong) UIButton *faceSelBtn;

@property (nonatomic, strong) UIButton *secretBtn;

@property (nonatomic, strong) UILabel *retainNumlab;

@property (nonatomic, strong) XJScope *scope;

@property (nonatomic, assign) id<PublishToolsSelDelegate>delegate;

@end
