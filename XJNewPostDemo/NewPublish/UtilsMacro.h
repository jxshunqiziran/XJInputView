//
//  UtilsMacro.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/6.
//  Copyright © 2018年 XJ. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h

#import "UIColor+Extension.h"
#import "UIView+FrameUtilty.h"
#import <Masonry.h>
#import "ETAlertView.h"


#define SavePics @"pics"

#define SaveText @"text"

#define GETIMG(name) [UIImage imageNamed:name]

#define GETFONT(x) [UIFont fontWithName:@"Helvetica" size:x]

#define XJSCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define XJSCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define SCALE_WIDTH(x) (x/375.0)*XJSCREENWIDTH

#define ND   [NSUserDefaults standardUserDefaults]

#define NC   [NSNotificationCenter defaultCenter]

#define XJColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define ThemeColor XJColor(236, 114, 38)

#define WeakSelf(weakSelf) __weak typeof(self)  weakSelf = self;//弱引用


#define showAlertTwoButton(message,title1,block1,title2,block2) {[ETAlertView showTwoButtonsWithTitle:@"提示" Message:message ButtonType:ETAlertViewButtonTypeCancel ButtonTitle:title1 Click:block1 ButtonType:ETAlertViewButtonTypeDefault ButtonTitle:title2 Click:block2];}

#endif /* UtilsMacro_h */
