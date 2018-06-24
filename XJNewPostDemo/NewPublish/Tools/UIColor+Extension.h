//
//  UIColor+Extension.h
//  WeChat_JX
//
//  Created by 江鑫 on 16/12/7.
//  Copyright © 2016年 江鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

+ (UIColor *)color:(UIColor *)color_ withAlpha:(float)alpha_;
@end
