//
//  XJToolBarScrollView.h
//  XJInputView
//
//  Created by 江鑫 on 2018/8/31.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XJToolBarItem :NSObject

@property (nonatomic, copy) NSString *imageNamed;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger index;

@end

@interface XJToolBarScrollView : UIScrollView


@end
