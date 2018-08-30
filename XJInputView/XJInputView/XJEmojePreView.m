//
//  XJEmojePreView.m
//  XJInputView
//
//  Created by 江鑫 on 2018/8/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJEmojePreView.h"
#import "XJInputDefine.h"

@interface XJEmojePreView ()

@property (nonatomic, strong) UILabel *emojiLabel;

@property (nonatomic, strong) UIImageView *emojeImageView;

@end

@implementation XJEmojePreView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        
        self.backgroundColor = [UIColor clearColor];
        UIImageView *BgimageView = [[UIImageView alloc] initWithFrame:self.bounds];
        BgimageView.image = GETIMG(@"EmoticonTips");
        [self addSubview:BgimageView];
        
        CGFloat selfW = self.frame.size.width;
        
        _emojeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((selfW-30)/2, 5, 30, 30)];
        [self addSubview:_emojeImageView];
        
        _emojiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, selfW, 30)];
        _emojiLabel.font = [UIFont systemFontOfSize:12];
        _emojiLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_emojiLabel];
        
    }
    return self;
}

- (void)setEmojeString:(NSString*)emojeString emojeImageNamed:(NSString*)imageNamed;
{
    _emojiLabel.text = emojeString;
    _emojeImageView.image = [[XJFaceInputHelper shareFaceHelper]getBundleImage:imageNamed];
}
@end
