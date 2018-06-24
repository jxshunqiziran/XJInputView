//
//  XJFaceView.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/7.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJFaceView.h"
#import "XJAnimatedImageView.h"
#import <YYKit.h>

@interface XJFaceView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *pageScrollVeiw;

@property (nonatomic ,strong) UIPageControl *pageControl;

@end

@implementation XJFaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupView];
        
    }
    return self;
    
}

- (void) setupView
{
    
    CGFloat selfW = self.frame.size.width;
    CGFloat selfH = self.frame.size.height;
    
    //1、底部滑动试图:
    _pageScrollVeiw = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, selfW, selfH)];
    _pageScrollVeiw.delegate = self;
    _pageScrollVeiw.pagingEnabled = YES;
    _pageScrollVeiw.decelerationRate = 0.01f;
    _pageScrollVeiw.showsHorizontalScrollIndicator = NO;
    _pageScrollVeiw.contentSize = CGSizeMake(XJSCREENWIDTH*5, self.frame.size.height);
    [self addSubview:_pageScrollVeiw];
    
    //2、加载表情富文本:
    [self loadEmotionAttributedView];
    
    
    //3、页面控制器:
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((selfW-200)/2, selfH - 40, 200, 30)];
    _pageControl.numberOfPages  = 5;
    _pageControl.backgroundColor =[UIColor clearColor];
    _pageControl.pageIndicatorTintColor =[UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = ThemeColor;
    [_pageControl addTarget:self action:@selector(actionPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_pageControl];
    
}


- (void) loadEmotionAttributedView
{
    
    NSString*path = [[NSBundle mainBundle]pathForResource:@"expression" ofType:@"plist"];
    NSDictionary *emtionDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *allkeys = [emtionDic allKeys];
    
    
    //分离数据:
    NSMutableArray *kindArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *tempArray;
    for (int i = 0; i < allkeys.count; i++) {
        
        if (i % 24 == 0) {
            
            tempArray  = [NSMutableArray arrayWithCapacity:0];
            [kindArray addObject:tempArray];
        }
        
        [tempArray addObject:allkeys[i]];
       
        
    }
    
    
    NSMutableArray*markArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0 ; i < kindArray.count; i++) {
        
        @autoreleasepool
        {
            YYLabel *facelab = [[YYLabel alloc]initWithFrame:CGRectMake(XJSCREENWIDTH*i+5, -10, XJSCREENWIDTH, self.frame.size.height -10)];
            facelab.tag = i;
            facelab.backgroundColor = [UIColor whiteColor];
            facelab.numberOfLines = 0;
            [_pageScrollVeiw addSubview:facelab];
            
            NSMutableDictionary * attactTextDic = [NSMutableDictionary dictionaryWithCapacity:0];
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            UIFont *font = [UIFont systemFontOfSize:16];
            
            NSArray *keyArray = kindArray[i];
            
            for (NSString *key in keyArray) {
                
                NSString *imageNamed = [[emtionDic[key]componentsSeparatedByString:@"@"]firstObject];
                UIImage *image = [UIImage imageNamed:imageNamed];
                XJAnimatedImageView *imageView = [[XJAnimatedImageView alloc] initWithImage:image];
                NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(imageView.size.width+20, imageView.size.height+20) alignToFont:font alignment:YYTextVerticalAlignmentCenter];
                [text appendAttributedString:attachText];
                
                [attactTextDic setObject:key forKey:[NSValue valueWithRange:NSMakeRange(text.length-1, 1)]];
                
                [text setTextHighlightRange:NSMakeRange(text.length-1, 1) color:[UIColor whiteColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    
                    YYLabel*label = (YYLabel*)containerView;
                    NSDictionary*markDic = markArray[label.tag];
                    
                    if (self.delegate && [self.delegate respondsToSelector:@selector(faceViewClickEmotionString:EmojeNamed:)]) {
                        
                        NSString *emojeKey = markDic[[NSValue valueWithRange:range]];
                        NSString *imageNamed = [[emtionDic[emojeKey]componentsSeparatedByString:@"@"]firstObject];
                        [self.delegate faceViewClickEmotionString:emojeKey EmojeNamed:imageNamed];
                    }
                    
                }];
                
            }
            
            [markArray addObject:attactTextDic];
            facelab.attributedText = text;
        }
        
       
        
    }
    
}

#pragma mark    ----- UIScrollViewDelegate -----

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
   NSInteger index =  scrollView.contentOffset.x/XJSCREENWIDTH;
    
   _pageControl.currentPage = index;
    
}

- (void)actionPage
{
    
    _pageScrollVeiw.contentOffset = CGPointMake(_pageControl.currentPage* XJSCREENWIDTH, 0);
    
    [_pageControl setNeedsDisplay];
    
}
@end
