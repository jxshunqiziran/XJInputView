//
//  XJPrivateViewController.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/27.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJScope.h"

typedef void (^XJChooseScopeBlock) (XJScope *scope);

@interface XJPrivateViewController : UIViewController

@property (nonatomic , copy) XJChooseScopeBlock chooseScopeBlock;

@end
