//
//  XJPublishManager.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/24.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJPublishManager.h"
#import "XJTextAttachment.h"
#import <YYKit.h>

@implementation XJPublishManager

+ (NSMutableAttributedString*) transformEmotionWithString:(NSString*)originString;
{
    
    NSString*path = [[NSBundle mainBundle]pathForResource:@"expression" ofType:@"plist"];
    NSDictionary *emtionDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString * pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression * re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    //通过正则表达式来匹配字符串
    NSArray *resultArray = [re matchesInString:originString options:0 range:NSMakeRange(0, originString.length)];
    
   NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];

   NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:originString ];
    
    
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        
        //获取原字符串中对应的值
        NSString *subStr = [originString substringWithRange:range];
        
        if (emtionDic[subStr]) {
            
            XJTextAttachment *textAttachment = [[XJTextAttachment alloc] init];
            NSString *imageNamed =  [[emtionDic[subStr]componentsSeparatedByString:@"@"]firstObject];
            textAttachment.image = [UIImage imageNamed:imageNamed];
            
            NSMutableAttributedString *imageStr = [NSMutableAttributedString attachmentStringWithContent:[UIImage imageNamed:imageNamed] contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(30, 30) alignToFont:GETFONT(16) alignment:YYTextVerticalAlignmentCenter];
            imageStr.font = GETFONT(16);
//            [NSAttributedString attributedStringWithAttachment:textAttachment];
            
            NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
            [imageDic setObject:imageStr forKey:@"image"];
            [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
            //把字典存入数组中
            [imageArray addObject:imageDic];
            
        }
    }
    
    for (NSInteger i = imageArray.count -1; i >= 0; i--)
    {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }
    return attributeString;
}

+ (NSData *)compressImageLessThanMaxMemory:(NSInteger)maxMemory andData:(NSData *)originalData
{
    
    NSData *imgData = originalData;
    unsigned long inlength = imgData.length;
    NSLog(@"size before compress:%lu", inlength);
    
    if (imgData.length > (maxMemory*1024)) {
        UIImage *image = [UIImage imageWithData:imgData];
        
        // aimWidth == 0时不做图片分辨率压缩
        imgData = [self compressImageWithImage:image aimWidth:0 aimLength:maxMemory*1024 accuracyOfLength:1024];
    }
    
    inlength = imgData.length;
    NSLog(@"size after compress:%lu", inlength);
    
    return imgData;
    
}


/**
 二分法压缩图片体积;
 */
+ (NSData *)compressImageWithImage:(UIImage *)image aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy
{
    
    UIImage * newImage;
    if (width == 0) {
        newImage = image;
    } else {
        newImage = [self imageWithImage:image scaledToSize:CGSizeMake(width, width * image.size.height / image.size.width)];
    }
    
    NSData  * data = UIImageJPEGRepresentation(newImage, 1);
    NSInteger imageDataLen = [data length];
    
    if (imageDataLen <= length + accuracy) {
        return data;
    }else{
        NSData * imageData = UIImageJPEGRepresentation( newImage, 0.99);
        if (imageData.length < length + accuracy) {
            return imageData;
        }
        
        CGFloat maxQuality = 1.0;
        CGFloat minQuality = 0.0;
        int flag = 0;
        
        while (1) {
            CGFloat midQuality = (maxQuality + minQuality)/2;
            
            if (flag == 6) {
                NSLog(@"************* %ld ******** %f *************",UIImageJPEGRepresentation(newImage, minQuality).length,minQuality);
                return UIImageJPEGRepresentation(newImage, minQuality);
            }
            flag ++;
            
            NSData * imageData = UIImageJPEGRepresentation(newImage, midQuality);
            NSInteger len = imageData.length;
            
            if (len > length+accuracy) {
                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
                maxQuality = midQuality;
                continue;
            }else if (len < length-accuracy){
                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
                minQuality = midQuality;
                continue;
            }else{
                NSLog(@"-----%d------%f------%ld--end",flag,midQuality,len);
                return imageData;
                break;
            }
        }
    }
}

//对图片尺寸进行压缩,图片分辨率压缩;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (void)savePublishPics:(NSMutableArray*)picsArray;
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray * tempArray = [NSMutableArray arrayWithCapacity:0];
        for (UIImage *image in picsArray) {
            
            NSData *data = UIImageJPEGRepresentation(image, 1);
            [tempArray addObject:data];
            
        }
        
        [ND setObject:tempArray forKey:SavePics];
        
    });
    
}

/**
 计算文字字符个数:
 
 @param string 字符串
 @return 字符数量
 */
+ (NSInteger)lenghtWithString:(NSString *)string;
{
    
    NSUInteger len = string.length;
    // 汉字字符集
    NSString * pattern  = @"[\u4e00-\u9fa5]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    
    return len + numMatch;
    
}
@end
