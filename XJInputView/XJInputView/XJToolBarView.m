//
//  XJToolBarView.m
//  XJInputView
//
//  Created by 江鑫 on 2018/8/30.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJToolBarView.h"

@implementation XJToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        
        UIButton *vb = [[UIButton alloc]initWithFrame:self.bounds];
        vb.backgroundColor = [UIColor redColor];
        [self addSubview:vb];
        
    }
    return self;
    
}

@end
