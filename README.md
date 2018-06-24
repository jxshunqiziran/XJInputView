# XJNewPost
仿微博发布界面,包括表情,图文混编,图片选择查看,富文本,@选人,范围选人,图片压缩,缓存

最终实现效果:
![仿微博](https://github.com/jxshunqiziran/XJNewPost/blob/master/newPost.gif)

大多数app都有发布帖子,事项,文章,,,,等功能,其实其中需要我们注意点有很多,这里我参照比较难一点的微博发布界面做了一个发微博界面,,,,

做之前我们需要考虑的地方有:

1. 页面整体布局;
2. 类似微信,点击表情按钮以及开始输入文字时,底部会随着键盘和表情面板高度上移下移;
2. 要求可以输入表情,可以显示表情面板选择,并且要考虑图片和文字在一起的计算高度的问题;
3. 可以添加图片,最多9张,图片可以拖动更改位置并且可以查看,删除,图片自适应文字输入随着输入下移;
4. 可以选择@别人,发布时可以将@人的id传给后台;
5. 缓存,返回时可以存储图片和文字,下次进来直接显示或放进草稿箱;
6. 可以选择发布范围,并且底部显示选择的范围的名称以及可见不可见的人名;发布时拿到相应id;
7. 同步显示还可以输入的文字个数;
8. 多张图片时如何优化图片压缩,以及多张图片的上传回调;

那么接下来我们一个个解决上面的问题:

## 一、页面的整体布局

## 二、底部功能框会随着键盘和表情面板高度上移下移

监听键盘的出现和消失,
```
- (void) adjustPublishToolsViewFrame:(CGRect)rect publishSelType:(publishSelType)type;
{

    //动画改变frame:
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:animationDuration?animationDuration:0.25f];
    [UIView setAnimationCurve:[curve intValue]];
    
    self.publishToolView.est_top =  rect.origin.y - 89;
    
    if (type == publishSelTypeFace) {
        
        _faceView.est_top = XJSCREENHEIGHT - FaceVieHeight;
        
    }else{
        
        _faceView.est_top = XJSCREENHEIGHT;
    }
    
    [UIView commitAnimations];
    
}
```

## 三、表情处理

底部表情选择面板:
一个比较笨的方法就是创建这么多button,然后点击触发事件,这用做可以性能太低pass;

那么我们知道富文本是可以显示图片的,而且可以在一个控件中直接显示,我们将这么多表情用NSTextAttachment拼接成富文本字符串即可显示,但是要求我们可以点击相应的NSTextAttachment并传递值,那么YYLable的Highlight状态刚好可以做到这一点:
```
 for (int i = 0 ; i < kindArray.count; i++) {
        
        YYLabel *facelab = [[YYLabel alloc]initWithFrame:CGRectMake(XJSCREENWIDTH*i+5, -10, XJSCREENWIDTH, self.frame.size.height -10)];
        facelab.tag = i;
        facelab.backgroundColor = [UIColor whiteColor];
        facelab.numberOfLines = 0;
        [_pageScrollVeiw addSubview:facelab];
        
        NSMutableDictionary * attactTextDic = [NSMutableDictionary dictionaryWithCapacity:0];
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        UIFont *font = [UIFont systemFontOfSize:16];
        
        NSArray *keyArray = kindArray[i];
        
        for (NSString *key in keyArray) {
            
            NSString *imageNamed = [[emtionDic[key]componentsSeparatedByString:@"@"]firstObject];
            UIImage *image = [UIImage imageNamed:imageNamed];
            XJAnimatedImageView *imageView = [[XJAnimatedImageView alloc] initWithImage:image];
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:CGSizeMake(imageView.size.width+20, imageView.size.height+20) alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [text appendAttributedString:attachText];
            
            [attactTextDic setObject:key forKey:[NSValue valueWithRange:NSMakeRange(text.length-1, 1)]];
            
            [text setTextHighlightRange:NSMakeRange(text.length-1, 1) color:[UIColor whiteColor] backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                
                YYLabel*label = (YYLabel*)containerView;
                NSDictionary*markDic = markArray[label.tag];
                
                if (self.delegate && [self.delegate respondsToSelector:@selector(faceViewClickEmotionString:EmojeNamed:)]) {
                    
                    NSString *emojeKey = markDic[[NSValue valueWithRange:range]];
                    NSString *imageNamed = [[emtionDic[emojeKey]componentsSeparatedByString:@"@"]firstObject];
                    [self.delegate faceViewClickEmotionString:emojeKey EmojeNamed:imageNamed];
                }
                
            }];
            
        }
        
        [markArray addObject:attactTextDic];
        facelab.attributedText = text;
        
    }
```

这里没有可说的,读取info.plist里面的字典将数据分离,每份25个,然后遍历拼接根据找到图片名拼接NSMutableAttributedString,赋值YYLable的attributedText;这里用字典利用range记住点击所表示的文字如[微笑]并通过代理传递出去;

内容区显示输入表情:
```
#pragma mark  ------ FaceViewClickDelegate -------

- (void)faceViewClickEmotionString:(NSString *)emojeString EmojeNamed:(NSString *)emojeNamed
{
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithAttributedString:contentTextView.attributedText];
    
    UIImage *image = [UIImage imageNamed:emojeNamed];
    
    NSMutableAttributedString *imageStr = [NSMutableAttributedString attachmentStringWithContent:image  contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:GETFONT(16) alignment:YYTextVerticalAlignmentCenter];
    imageStr.font = GETFONT(16);
   
    [attributeString appendAttributedString:imageStr];
    
    contentTextView.attributedText = attributeString;
    
    [self adjustContentTextViewHeight];
}

```
YYText中图文混编通过NSMutableAttributedString拼接显示;

计算表情和文字的高度:这里通过YYTextLinePositionSimpleModifier固定一个高度防止表情和文字高度不统一导致计算有误;
```
    YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
    modifier.fixedLineHeight = 24;
    
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake(XJSCREENWIDTH - 36, CGFLOAT_MAX);
    container.linePositionModifier = modifier;
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:contentTextView.attributedText];
    CGFloat textHight = layout.textBoundingSize.height + 25;
    
    if (textHight > TextViewHeight) {
        
        contentTextView.est_height = textHight + 15;
        
    }else{
        
        contentTextView.est_height = TextViewHeight + 30;
        
    }
```

## 三、可以添加图片,最多9张,图片可以拖动更改位置并且可以查看,删除,图片自适应文字输入随着输入下移;
![屏幕快照 2018-03-01 23.54.54.png](http://upload-images.jianshu.io/upload_images/2099412-e6b34d4aac68d5cd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 四、可以选择@别人,发布时可以将@人的id传给后台;
![屏幕快照 2018-03-01 23.58.49.png](http://upload-images.jianshu.io/upload_images/2099412-54b1d6b1ee3d914f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 五、 缓存,返回时可以存储图片和文字,下次进来直接显示或放进草稿箱;![屏幕快照 2018-03-01 23.52.05.png](http://upload-images.jianshu.io/upload_images/2099412-253bfa72b470d529.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
    //异步取出图片并展示:
    NSMutableArray *savePicsArray = [ND objectForKey:SavePics];
    if (savePicsArray && savePicsArray.count > 0) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            for (NSData *data in savePicsArray) {
                
                UIImage *image = [UIImage imageWithData:data];
                [self.picsArray addObject:image];
                
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [ND setObject:[NSMutableArray new] forKey:SavePics];
                [self.picsCollectonView reloadData];
                
            });
            
        });
        
    }
```

## 六、可以选择发布范围,并且底部显示选择的范围的名称以及可见不可见的人名;发布时拿到相应id

## 七、同步显示还可以输入的文字个数;
```
/**
 剩余输入字符数量:
 */
- (void) calculateRemainNum
{
    
    NSInteger remain = MaxContentNum - [XJPublishManager lenghtWithString:contentTextView.text];
    
    self.publishToolView.retainNumlab.text = [NSString stringWithFormat:@"%ld",remain];
    
}
```

## 八、多张图片压缩以及上传:


```
//有图片先上传图片,并获取图片url:
        NSMutableArray *imgDatas = [[NSMutableArray alloc] initWithCapacity:0];
        
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_group_async(group, queue, ^{
            
            for (UIImage *image in self.picsArray) {
                
                NSData *protraitData = UIImageJPEGRepresentation(image,1);
                protraitData = [XJPublishManager compressImageLessThanMaxMemory:200 andData:protraitData];
                
                [imgDatas addObject:protraitData];
                
            }
            
        });
        
        WeakSelf(weakSelf);
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            
            //上传imagedatas,通过回调得到url;
            //处理at;
            //发送发布请求;
            [weakSelf dealWithAtUser];
            
        });
    }
```

