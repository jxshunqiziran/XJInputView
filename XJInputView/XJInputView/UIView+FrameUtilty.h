//
//  UIView+FrameUtilty.h
//  CircleFriend
//
//  Created by 江鑫 on 2017/12/5.
//  Copyright © 2017年 智享时代. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameUtilty)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat xj_left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat xj_top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat xj_right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat xj_bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat xj_width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat xj_height;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint est_origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize est_size;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat est_centerX;

/**
 *  右上角
 *  self.origin.x+self.size.width,self.origin.y
 */
@property (nonatomic) CGPoint est_topRight;

/**
 *  左下角
 *
 *  self.origin.x,self.origin.y+self.size.height
 */
@property (nonatomic) CGPoint est_bottomLeft;

/**
 *  右下角
 *
 *  self.origin.x+self.size.width,self.origin.y+self.size.height
 */
@property (nonatomic) CGPoint est_bottomRight;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat est_centerY;

/**
 *  Shortcut for right to superview
 *  Sets frame.origin.x = superview.width - rightToSuper -frame.size.width
 */
@property (nonatomic) CGFloat est_rightToSuper;

/**
 *  shortcut for bottom to superview
 *  set frame.origin.y = superview.height - bottomToSuper - frame.size.height
 */
@property (nonatomic) CGFloat est_bottomToSuper;

@end
