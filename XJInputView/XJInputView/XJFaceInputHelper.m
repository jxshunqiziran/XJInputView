//
//  XJFaceInputHelper.m
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/24.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJFaceInputHelper.h"

static XJFaceInputHelper *_faceHelper = nil;

@implementation XJFaceInputHelper

+ (instancetype)shareFaceHelper;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _faceHelper = [[XJFaceInputHelper alloc]init];
    });
    return _faceHelper;
}


- (NSDictionary*)attributes
{
    if (!_attributes) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = 4;// 字体的行间距
        _attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSParagraphStyleAttributeName:paragraphStyle};
    }
    return _attributes;
}


- (NSDictionary*)emojeDic
{
    if (!_emojeDic) {
        NSString*path = [[NSBundle mainBundle]pathForResource:@"expression" ofType:@"plist"];
        _emojeDic = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _emojeDic;
}

- (NSMutableArray*)emojeKindsArray
{
    if (!_emojeKindsArray) {
        _emojeKindsArray = [NSMutableArray arrayWithObjects:@"EmotionsEmojiHL",@"EmotionCustomHL", nil];
    }
    return _emojeKindsArray;
}


/**
 整理数据源,取到所有表情数组;
 */
- (NSMutableArray*)getAllEmojePage;
{
    
    NSArray *allkeys = [self.emojeDic allKeys];
    NSMutableArray *array = [NSMutableArray arrayWithArray:allkeys];
    while (array.count %23 != 0) {
        [array addObject:@""];
    }
    NSMutableArray *allPageArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *tempArray = nil;
    for (int i = 0; i < array.count; i++) {
        if (i % 23 == 0) {
            [tempArray addObject:@"DeleteEmoticonBtn"];
            tempArray = [NSMutableArray arrayWithCapacity:0];
            [allPageArray addObject:tempArray];
        }
        [tempArray addObject:array[i]];
    }
    return allPageArray;
    
}


/**
 获取bundle内的图片;
 */
- (UIImage*)getBundleImage:(NSString*)imageNamed
{
    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"xjemoje1" ofType:@"bundle"];
    NSString *imgPath= [strResourcesBundle stringByAppendingPathComponent:imageNamed];
    UIImage *imgC = [UIImage imageWithContentsOfFile:imgPath];
    return imgC;
}

- (UIImage*)getNormalBundleImage:(NSString*)imageNamed;
{
    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"XJInputView" ofType:@"bundle"];
    NSString *imgPath= [strResourcesBundle stringByAppendingPathComponent:imageNamed];
    UIImage *imgC = [UIImage imageWithContentsOfFile:imgPath];
    return imgC;
}


+ (CGFloat)calculteImageHeight;
{
    
    UIFont *font = [UIFont systemFontOfSize:17];
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize maxsize = CGSizeMake(100, MAXFLOAT);
    CGSize size = [@"/" boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.height;
    
}
@end
