//
//  ETSingleTon.m
//  ESTTOAIM
//
//  Created by 江鑫 on 2017/12/6.
//  Copyright © 2017年 智享时代. All rights reserved.
//

#import "ETSingleTon.h"

@implementation ETSingleTon

+ (instancetype)shareSingleTon{
    static ETSingleTon *shareSingleTonInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareSingleTonInstance = [ETSingleTon new];
    });
    return shareSingleTonInstance;
}

- (UIWindow *)backgroundWindow{
    if (!_backgroundWindow) {
        _backgroundWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundWindow.windowLevel = UIWindowLevelStatusBar - 1;
    }
    return _backgroundWindow;
}

- (NSMutableArray *)alertStack{
    if (!_alertStack) {
        _alertStack = [NSMutableArray array];
    }
    return _alertStack;
}

@end
