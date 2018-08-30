//
//  XJInputDefine.h
//  XJInputView
//
//  Created by 江鑫 on 2018/8/24.
//  Copyright © 2018年 XJ. All rights reserved.
//

#ifndef XJInputDefine_h
#define XJInputDefine_h

#import "XJFaceInputHelper.h"
#import <Masonry.h>
#import "UIView+FrameUtilty.h"
#import "UIColor+ZS.h"
#import <TZImagePickerController.h>

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define NavigationHeight (kDevice_Is_iPhoneX ? 88:64)//适配X导航栏高度

#define MainScreen [[UIScreen mainScreen] bounds] //整个屏幕bounds

#define XJScreenWidth MainScreen.size.width       //屏幕宽度

#define XJScreenHeight (kDevice_Is_iPhoneX ? (MainScreen.size.height - 34):MainScreen.size.height)//排除X底部感应高度  //屏幕高度

#define GETIMG(name) [[XJFaceInputHelper shareFaceHelper]getNormalBundleImage:name]

#define GETFONT(size) [UIFont systemFontOfSize:size] //字体大小

#define XJColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]   //rgb颜色

#define WeakSelf(weakSelf) __weak typeof(self)  weakSelf = self;

#define NoTiCenter   [NSNotificationCenter defaultCenter]

#endif /* XJInputDefine_h */
