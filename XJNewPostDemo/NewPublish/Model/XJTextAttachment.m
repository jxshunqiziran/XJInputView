//
//  XJTextAttachment.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/25.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJTextAttachment.h"

@implementation XJTextAttachment

//重载此方法 使得图片的大小和行高是一样的。
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    return CGRectMake(0, -3, lineFrag.size.height, lineFrag.size.height);
}



@end
