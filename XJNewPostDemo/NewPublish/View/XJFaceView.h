//
//  XJFaceView.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/7.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FaceViewClickDelegate<NSObject>

- (void) faceViewClickEmotionString:(NSString*)emojeString EmojeNamed:(NSString*)emojeNamed;

@end



@interface XJFaceView : UIView

@property (nonatomic, assign) id<FaceViewClickDelegate>delegate;

@end
