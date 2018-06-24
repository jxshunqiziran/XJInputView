//
//  XJScope.h
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/3/1.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,XJNewPublishScopeType)
{
    XJNewPublishScopeTypeAll,
    XJNewPublishScopeTypeMySelf,
    XJNewPublishScopeTypeFriends,
    XJNewPublishScopeTypeApart,
    XJNewPublishScopeTypeSecret,
};

@interface XJScope : NSObject

@property (nonatomic, assign) XJNewPublishScopeType scopeType;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, strong) NSMutableArray *selusers;

@property (nonatomic, copy) NSString *scopeid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL isCover;

@end
