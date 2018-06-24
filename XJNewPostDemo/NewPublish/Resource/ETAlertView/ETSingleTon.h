//
//  ETSingleTon.h
//  ESTTOAIM
//
//  Created by 江鑫 on 2017/12/6.
//  Copyright © 2017年 智享时代. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ETAlertView.h"

@interface ETSingleTon : NSObject

@property (nonatomic, strong) UIWindow *backgroundWindow;
@property (nonatomic, weak) UIWindow *oldKeyWindow;
@property (nonatomic, strong) NSMutableArray *alertStack;
@property (nonatomic, strong) ETAlertView *previousAlert;

+ (instancetype)shareSingleTon;
- (UIWindow *)backgroundWindow;

@end
