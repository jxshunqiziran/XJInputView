//
//  ETAlertView.h
//  ESTTOAIM
//
//  Created by 江鑫 on 2017/12/6.
//  Copyright © 2017年 智享时代. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const JCAlertViewWillShowNotification;
UIKIT_EXTERN NSString *const JCAlertViewDidShowNotification;
UIKIT_EXTERN NSString *const JCAlertViewWillDismissNotification;
UIKIT_EXTERN NSString *const JCAlertViewDidDismissNotification;

typedef void(^clickHandle)(void);

typedef void(^clickHandleWithIndex)(NSInteger index);

typedef NS_ENUM(NSInteger, ETAlertViewButtonType) {
    ETAlertViewButtonTypeDefault = 0,
    ETAlertViewButtonTypeCancel,
    ETAlertViewButtonTypeWarn
};

@protocol JCAlertViewDelegate <NSObject>

- (void)didTapCoverView;

@end

@interface  ETAlertView: UIView

@property(nonatomic, assign) id<JCAlertViewDelegate>delegate;

// ------------------------Show AlertView with title and message----------------------

// show alertView with 1 button
+ (void)showOneButtonWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(ETAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click;

// show alertView with 2 buttons
+ (void)showTwoButtonsWithTitle:(NSString *)title Message:(NSString *)message ButtonType:(ETAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonTitle Click:(clickHandle)click ButtonType:(ETAlertViewButtonType)buttonType ButtonTitle:(NSString *)buttonType Click:(clickHandle)click;

// show alertView with greater than or equal to 3 buttons
// parameter of 'buttons' , pass by NSDictionary like @{JCAlertViewButtonTypeDefault : @"ok"}
+ (void)showMultipleButtonsWithTitle:(NSString *)title Message:(NSString *)message Click:(clickHandleWithIndex)click Buttons:(NSDictionary *)buttons,... NS_REQUIRES_NIL_TERMINATION;

// ------------------------Show AlertView with customView-----------------------------

// create a alertView with customView.
// 'dismissWhenTouchBackground' : If you don't want to add a button on customView to call 'dismiss' method manually, set this property to 'YES'.
- (instancetype)initWithCustomView:(UIView *)customView dismissWhenTouchedBackground:(BOOL)dismissWhenTouchBackground;

- (void)configAlertViewPropertyWithTitle:(NSString *)title Message:(NSString *)message Buttons:(NSArray *)buttons Clicks:(NSArray *)clicks ClickWithIndex:(clickHandleWithIndex)clickWithIndex;

- (void)show;

// alert will resign keywindow in the completion.
- (void)dismissWithCompletion:(void(^)(void))completion;
@end
