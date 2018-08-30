//
//  UIColor+ZS.h
//  ZhaoShang
//
//  Created by yangyun on 15/3/27.
//  Copyright (c) 2015年 yangyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZS)
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;
@end
