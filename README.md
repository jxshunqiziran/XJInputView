# XJNewPost

###效果
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
- [x] 编辑图片 (支持多种滤镜，可自定义裁剪比例)
- [x] 编辑视频


### Feature

> 如果您在使用中有好的需求及建议，或者遇到什么bug，欢迎随时issue，我会及时的回复
 
### 更新日志
> [更多更新日志](https://github.com/longitachi/ZLPhotoBrowser/blob/master/UPDATELOG.md)
```
● 2.7.4: 横滑大图界面添加下拉返回; 不允许录制视频时候不请求麦克风权限;
● 2.7.1: 支持自定义导航返回按钮图片;
● 2.7.0: 图片资源加上前缀，解决9.0无法选择图片问题; 
● 2.6.9: 重构编辑图片功能，添加滤镜;
● 2.6.7: 优化视频编辑界面，极大减少进入时的等待时间;
● 2.6.6: Fix #216; 新增隐藏裁剪图片界面比例工具条功能;
● 2.6.5: 新增隐藏"已隐藏"照片及相册的功能; Fix #221, 优化预览网络图片/视频时根据url后缀判断的类型方式;
● 2.6.4: Fix #181, #184, #185;
● 2.6.3: 新增自定义多语言文本功能; 新增预览网络视频功能;
● 2.6.2: 新增是否保存已编辑图片的参数; 优化编辑图片旋转体验; 新增取消选择回调;
● 2.6.1: 新增导出视频添加粒子特效功能(如下雪特效); 新增编辑图片时旋转图片功能;
● 2.6.0: ①：新增调用系统相机录制视频功能;
         ②：支持导出指定尺寸的视频，支持导出视频添加图片水印;
         ③：优化部分UI显示;
● 2.5.5: 视频导出方法中添加压缩设置参数; 支持app名字国际化的获取; 删除视频导出3gp格式; fix #157;
● 2.5.4: 新增视频导出功能; 新增获取图片路径api; 优化自定义相机，当相机消失后恢复其他音乐软件的播放;
● 2.5.3: 拍摄视频及编辑视频支持多种格式(mov, mp4, 3gp); 新增相册名字等多语言，以完善手动设置语言时相册名字跟随系统的问题; 简化相册调用，configuration 由必传参数修改为非必传参数;
● 2.5.2: 提取相册配置参数独立为'ZLPhotoConfiguration'对象; 新增状态栏样式api; 优化部分代码;
● 2.5.1: ①：新增自定义相机(仿微信)，开发者可选使用自定义相机或系统相机;
         ②：支持录制视频，可设置最大录制时长及清晰度;
● 2.5.0.2: 新增自行切换框架语言api; 编辑图片界面当只有一个比例且为custom或1:1状态下隐藏比例切换工具条;
● 2.5.0.1: 提供逐个解析图片api，方便 shouldAnialysisAsset 为 NO 时的使用; 提供控制是否可以选择原图参数;
● 2.5.0: 新增选择后是否自动解析图片参数 shouldAnialysisAsset (针对需要选择大量图片的功能，框架一次解析大量图片时，会导致内存瞬间大幅增高，建议此时置该参数为NO，然后拿到asset后自行逐个解析); 修改图片压缩方式，确保原图尺寸不变
```

### 框架支持
最低支持：iOS 8.0 

IDE：Xcode 9.0 及以上版本 (由于适配iPhone X使用iOS11api，所以请使用Xcode 9.0及以上版本)

### <a id="使用方法"></a>使用方法


代码中调用
```objc
#import "ZLPhotoActionSheet.h"
    
ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];

//相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
ac.configuration.maxSelectCount = 5;
ac.configuration.maxPreviewCount = 10;

//如调用的方法无sender参数，则该参数必传
ac.sender = self;

//选择回调
[ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
    //your codes
}];

//调用相册
[ac showPreviewAnimated:YES];

//预览网络图片
[ac previewPhotos:arrNetImages index:0 hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
    //your codes
}];
```

------------------

