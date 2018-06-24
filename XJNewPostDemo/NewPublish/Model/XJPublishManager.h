//
//  XJPublishManager.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/24.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJPublishManager : NSObject

+ (NSMutableAttributedString*) transformEmotionWithString:(NSString*)originString;


+ (NSData *)compressImageLessThanMaxMemory:(NSInteger)maxMemory andData:(NSData *)originalData;


+ (void)savePublishPics:(NSMutableArray*)picsArray;


/**
 计算文字字符个数:

 @param string 字符串
 @return 字符数量
 */
+ (NSInteger)lenghtWithString:(NSString *)string;

@end
