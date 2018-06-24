//
//  XJAtUserViewController.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJUser.h"

typedef void (^XJChooseAtUserBlock) (XJUser *user);

@interface XJAtUserViewController : UIViewController

@property (nonatomic , copy) XJChooseAtUserBlock chooseUserBlock;

@end
