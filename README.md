# XJInputView

###实现效果
##### 发布界面输入框:
![image](https://github.com/jxshunqiziran/XJInputView/blob/master/newPost.gif)
##### 评论界面输入框:
![image](https://github.com/jxshunqiziran/XJInputView/blob/master/comment.gif)
##### 聊天界面输入框:

### 框架整体介绍
* [功能介绍](#功能介绍)
* [更新日志](#更新日志)
* [使用方法(支持cocoapods安装)](#使用方法)
* [English Document](#English)
* [问答](#问答)
* [效果图](#效果图)

### <a id="功能介绍"></a>功能介绍
- [x] 发布界面输入框
- [x] 表情键盘
- [x] 表情长按、删除、多选择
- [x] 表情和文字输入自适应高度,自动计算高度值
- [x] 支持聊天面板的输入


### Feature

> 如果您在使用中有好的需求及建议，或者遇到什么bug，欢迎随时issue，我会及时的回复
 
### 更新日志
> [更多更新日志](https://github.com/longitachi/ZLPhotoBrowser/blob/master/UPDATELOG.md)
```
● 2.7.4: 整体输入框架构重建;
● 2.7.1: 添加表情长按;
● 2.7.0: 优化聊天输入框,界面键盘弹起位置的问题; 
● 2.6.9: 重构编辑图片功能，添加滤镜;

```

### 框架支持
最低支持：iOS 8.0 

IDE：Xcode 9.0 及以上版本 (由于适配iPhone X使用iOS11api，所以请使用Xcode 9.0及以上版本)

### <a id="使用方法"></a>使用方法


代码中调用
```objc
(1)发布输入框:
#import "XJItemSelView.h"
    
    XJItemSelView * inputView = [XJItemSelView showInputViewInView:self.view itemSelfType:XJItemSelTypeMulitfuntion contentTextView:_contentTextView];
    inputView.faceEmojeView.delegate = self;
    inputView.mulitFuctionView.delegate = self;
    
    
(2)评论界面输入框:
   XJItemSelView*inputView = [XJItemSelView showInputViewInView:self.view itemSelfType:XJItemSelTypeInput contentTextView:nil];
   
   
(3)聊天界面输入框:
       XJItemSelView*inputView = [XJItemSelView showInputViewInView:self.view itemSelfType:XJItemSelTypeChat contentTextView:nil];
```

------------------

