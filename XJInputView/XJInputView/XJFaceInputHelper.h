//
//  XJFaceInputHelper.h
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/24.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XJFaceInputHelper : NSObject

+ (instancetype)shareFaceHelper;

@property (nonatomic, strong) NSDictionary *attributes;

@property (nonatomic, strong) NSDictionary *emojeDic;

@property (nonatomic, strong) NSMutableArray *emojeKindsArray;

- (NSMutableArray*)getAllEmojePage;

- (UIImage*)getBundleImage:(NSString*)imageNamed;

- (UIImage*)getNormalBundleImage:(NSString*)imageNamed;

/**
 计算表情的宽高;
 */
+ (CGFloat)calculteImageHeight;

@end
