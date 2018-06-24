//
//  XJNewPublishViewController.m
//  XJNewPostDemo
//
//  Created by 江鑫 on 2018/2/6.
//  Copyright © 2018年 XJ. All rights reserved.
//

//表情显示方案二:YYText添加解析器,也可实现;
/*
 YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
 NSMutableDictionary *mapper = [NSMutableDictionary new];
 mapper[@"微笑"] = [UIImage imageNamed:@"Expression_1"];
 parser.emoticonMapper = mapper;
 contentTextView.textParser = parser;
 */

#import "XJNewPublishViewController.h"
#import "XJPublishToolsView.h"
#import "XJFaceView.h"
#import "XJPublishManager.h"
#import "XJCollectionViewCell.h"
#import "HZPhotoBrowser.h"
#import <TZImagePickerController.h>
#import <YYTextView.h>
#import <YYKit.h>
#import "XJAtUserViewController.h"
#import "XJPrivateViewController.h"

@interface XJNewPublishViewController ()<PublishToolsSelDelegate,UITextViewDelegate,UIScrollViewDelegate,FaceViewClickDelegate,UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,HZPhotoBrowserDelegate,YYTextViewDelegate>
{
    YYTextView *contentTextView;
    
    double animationDuration;
    
    NSString *contentString;
    
    NSNumber *curve;
}

@property (nonatomic, strong) XJPublishToolsView *publishToolView;

@property (nonatomic, strong) XJFaceView *faceView;

@property (nonatomic, strong) UIScrollView *backScrollView;

@property (nonatomic, strong) NSMutableArray *picsArray;

@property (nonatomic, strong) NSMutableArray *atArray;

@property (nonatomic, strong) UICollectionView *picsCollectonView;

@property (nonatomic, strong) UILabel *remainLab;

@property (nonatomic, strong) UIButton *secretBtn;

@end

@implementation XJNewPublishViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupView];
    
    [self addNotification];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    NSString *saveText = [ND objectForKey:SaveText];
    if (saveText.length&&contentTextView.text.length==0)contentTextView.text = saveText;
    [ND setObject:@"" forKey:SaveText];
    [self calculateRemainNum];
    
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
    
    
}


- (void)addNotification
{
    
    [NC addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [NC addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


- (void) setupView
{
    
    if (@available(iOS 11.0, *)){
        self.backScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    contentString = @"";
    
    [self.view addSubview:self.backScrollView];
    
    
    contentTextView = [[YYTextView alloc]initWithFrame:CGRectMake(0, 64, XJSCREENWIDTH, TextViewHeight)];
    contentTextView.scrollEnabled = NO;
    contentTextView.textContainerInset = UIEdgeInsetsMake(10, 18, 10, 18);
    contentTextView.font = GETFONT(16);
    contentTextView.textColor = [UIColor colorWithHexString:@"#404040"];
    [contentTextView setTintColor:ThemeColor];
    contentTextView.delegate = self;
    contentTextView.placeholderText =  @"分享新鲜事...";
    [self.backScrollView addSubview:contentTextView];
    
    
    [self.backScrollView addSubview:self.picsCollectonView];

    [self.view addSubview:self.publishToolView];
    
}


- (void)viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
    
    [self adjustContentTextViewHeight];
    
    [self.picsCollectonView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(contentTextView.mas_bottom).offset(5);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(300);
        make.width.mas_equalTo(XJSCREENWIDTH);
        
    }];
    
}


- (void) setupNav
{
   
    self.navigationItem.title = @"发微博咯!";
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setTitle:@"发布" forState:UIControlStateNormal];
    commitBtn.frame = CGRectMake(0, 0, 50, 16);
    commitBtn.titleLabel.font = GETFONT(15);
    commitBtn.layer.cornerRadius = 6;
    commitBtn.layer.masksToBounds = YES;
    commitBtn.backgroundColor = ThemeColor;
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitNewPost) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:commitBtn];

    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_btn_backEST"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
}

#pragma mark ------- init  -----------

- (XJPublishToolsView*)publishToolView
{
    
    if (!_publishToolView) {
        
        XJPublishToolsView *toolsView = [[XJPublishToolsView alloc]initWithFrame:CGRectMake(0, XJSCREENHEIGHT - 89, XJSCREENWIDTH, 300)];
        toolsView.delegate = self;
        _publishToolView = toolsView;
    }
    
    return _publishToolView;
}

- (XJFaceView*)faceView
{
    
    if (!_faceView) {
        
        XJFaceView *faceView = [[XJFaceView alloc]initWithFrame:CGRectMake(0, XJSCREENHEIGHT, XJSCREENWIDTH, FaceVieHeight)];
        faceView.delegate = self;
        [self.view addSubview:faceView];
        _faceView = faceView;
    }
    
    return _faceView;
}

- (UIScrollView*)backScrollView
{
    
    if (!_backScrollView) {
        
        _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, XJSCREENWIDTH, XJSCREENHEIGHT - 89  )];
        _backScrollView.backgroundColor = [UIColor whiteColor];
        _backScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _backScrollView.delegate = self;
        _backScrollView.contentSize = CGSizeMake(XJSCREENWIDTH, XJSCREENHEIGHT);
        _backScrollView.showsVerticalScrollIndicator = YES;
    }
    
    return _backScrollView;
}



- (UICollectionView*)picsCollectonView
{
    if (!_picsCollectonView) {
        
        UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(SCALE_WIDTH(85), SCALE_WIDTH(68));;
        layout.sectionInset = UIEdgeInsetsMake(5, 15, 5, 15);
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 10;
        
        UICollectionView *picsCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        picsCollection.delegate = self;
        picsCollection.dataSource = self;
        picsCollection.scrollEnabled = NO;
        picsCollection.backgroundColor = [UIColor whiteColor];
        _picsCollectonView = picsCollection;
        
        [picsCollection registerClass:[XJCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPics:)];
        [picsCollection addGestureRecognizer:longPresssGes];
        
    }
    return _picsCollectonView;
    
}

- (NSMutableArray *) atArray
{
    if (!_atArray) {
        _atArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _atArray;
}

- (NSMutableArray *) picsArray
{
    if (!_picsArray) {
        _picsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _picsArray;
}

#pragma mark -------  keyboard Notification ------

// 键盘将要出现:
- (void)keyBoardWillShow:(NSNotification *)notification
{
    
    [self getKeyBoardInformation:notification];
    
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [self adjustPublishToolsViewFrame:keyboardRect publishSelType:publishSelTypeText];
    
}


//键盘将要消失:
- (void)keyBoardWillHide:(NSNotification *)notification
{
    [self getKeyBoardInformation:notification];
    
    [self adjustPublishToolsViewFrame:CGRectMake(0, XJSCREENHEIGHT, 0, 0) publishSelType:publishSelTypeText];
    
}

- (void)getKeyBoardInformation:(NSNotification*)notification
{
    
    animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
}


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


#pragma mark    ------  PublishToolsSelDelegate ----

- (void) publishToolsTypeSel:(publishSelType)type;
{
    
   
    switch (type) {
            
        case publishSelTypeFace:
        {
            
             [contentTextView resignFirstResponder];
            self.faceView.backgroundColor = [UIColor whiteColor];
            [self adjustPublishToolsViewFrame:CGRectMake(0, XJSCREENHEIGHT - FaceVieHeight, XJSCREENWIDTH, FaceVieHeight) publishSelType:publishSelTypeFace];
            
        }
            break;
            
        case publishSelTypeText:
        {
            [self adjustPublishToolsViewFrame:CGRectMake(0, XJSCREENHEIGHT, XJSCREENWIDTH, FaceVieHeight) publishSelType:publishSelTypeFace];
            [contentTextView becomeFirstResponder];
            
        }
            break;
            
        case publishSelTypeAt:
        {
            //3、at选人:
            [contentTextView resignFirstResponder];
            XJAtUserViewController*VC = [[XJAtUserViewController alloc]init];
            WeakSelf(weakSelf);
            VC.chooseUserBlock = ^(XJUser *user) {
                
                
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithAttributedString:contentTextView.attributedText];
                
                NSMutableAttributedString *atAttribute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"@%@ ",user.name]];
                atAttribute.font = GETFONT(16);
                [attributeString appendAttributedString:atAttribute];
                
                contentTextView.attributedText = attributeString;
                
                [weakSelf calculateRemainNum];
                [self.atArray addObject:user];
                
            };
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
            
        case publishSelTypePic:
        {
            
            //4、选择图片:
            [self goTZImagePickerController];
            
        }
            break;
        
        case publishSelTypeScope:
        {
            
            //5、选择可见范围:
            [contentTextView resignFirstResponder];
            XJPrivateViewController*VC = [[XJPrivateViewController alloc]init];
            WeakSelf(weakSelf);
            VC.chooseScopeBlock = ^(XJScope *scope) {
                
                weakSelf.publishToolView.scope = scope;
                
            };
            [self.navigationController pushViewController:VC animated:YES];
            
        }
            break;
        default:
            break;
    }
    
    
}

#pragma mark ---- UIScrollViewDelegate ----

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    
    // 缩回键盘
    [self adjustPublishToolsViewFrame:CGRectMake(0, XJSCREENHEIGHT, 0, 0) publishSelType:publishSelTypeText];
    self.publishToolView.faceSelBtn.selected = NO;
    
}


#pragma mark  ------  YYTextViewDelegate --------

- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView
{
   
    return YES;
}

- (void)textViewDidBeginEditing:(YYTextView *)textView
{
    
    self.publishToolView.faceSelBtn.selected = NO;
    [textView becomeFirstResponder];
    
}


- (void)textViewDidChange:(YYTextView *)textView;
{
    
    contentString = textView.text;
    
    [self adjustContentTextViewHeight];
    
    //可输入字符个数:
    [self calculateRemainNum];
    
}


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
    
    //可输入字符个数:
    [self calculateRemainNum];
  
    /*
    废弃:
    NSMutableString *formString = [[NSMutableString alloc]initWithString:contentString];

    [formString appendString:emojeString];

    contentTextView.text = formString;

   contentTextView.attributedText =  [XJPublishManager transformEmotionWithString:contentTextView.text];
    
    [self textViewDidChange:contentTextView];*/
    
}


#pragma mark ------- UICollectionViewDelegate --------

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.picsArray.count == 0 || self.picsArray.count == MaxPicsNum) {
        return self.picsArray.count;
    }
    return self.picsArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    XJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.index = indexPath.item;
    
    if (indexPath.item == self.picsArray.count) {
        
        cell.deleteBtn.hidden = YES;
        [cell setPicImageView:GETIMG(@"btn_add")];
        
    }else{
        
        cell.deleteBtn.hidden = NO;
        UIImage *picImage = self.picsArray[indexPath.item];
        [cell setPicImageView:picImage];
        WeakSelf(weakSelf);
        cell.deleteBtnClickBlock = ^(NSInteger index) {
           
           [weakSelf.picsArray removeObjectAtIndex:index];
           [weakSelf.picsCollectonView reloadData];
            
        };
    }
    return cell;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //添加图片:
    if (indexPath.item == self.picsArray.count) {
        
        [self goTZImagePickerController];
        return;
    }
    
    //查看图片:(这里用到第三方HZPhotoBrowser)
    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
    browserVc.sourceImagesContainerView = collectionView; // 原图的父控件
    browserVc.imageCount = self.picsArray.count; // 图片总数
    browserVc.currentImageIndex = (int)indexPath.item;
    browserVc.delegate = self;
    [browserVc show];
    
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    //如果移到添加按钮后面，就退出，不能移动
    NSInteger destinationRow = destinationIndexPath.row;
    NSInteger picsCout = self.picsArray.count;
    if (destinationRow == picsCout)
    {

        return;
    }
    
    UIImage *picImage = self.picsArray[sourceIndexPath.item];
    
    [_picsArray removeObjectAtIndex:sourceIndexPath.row];
    
    [_picsArray insertObject:picImage atIndex:destinationIndexPath.row];
    
}

#pragma mark -----  TZImagePickerControllerDelegate -----

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto;
{
    
    [self.picsArray addObjectsFromArray:photos];
    
    [self.picsCollectonView reloadData];
    
}


#pragma mark -----  Private Method ----

- (void) back
{
    
    if (contentTextView.text.length != 0 || self.picsArray.count !=0) {
        
        showAlertTwoButton(@"您已经编辑相关内容,是否保存?", @"否", ^{
            
           [self.navigationController popViewControllerAnimated:YES];
            
        }, @"是", ^{
           
           if(self.picsArray.count !=0) [XJPublishManager savePublishPics:self.picsArray];
           
           if (contentTextView.text.length != 0) [ND setObject:contentTextView.text forKey:SaveText];
           
           [self.navigationController popViewControllerAnimated:YES];
            
       });
        
    }
    
   
    
    
}


- (void)goTZImagePickerController
{
    
    TZImagePickerController*pickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:(MaxPicsNum-self.picsArray.count) delegate:self];
    pickerVC.allowPickingVideo = NO;
    pickerVC.allowPickingOriginalPhoto = NO;//待商榷;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}

/**
 调整pics的高度;
 */
- (void) adjustContentTextViewHeight
{
    
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

    /*废弃:采用YYTextLayout了
    CGRect textsize = [contentTextView.text boundingRectWithSize:CGSizeMake(XJSCREENWIDTH - 36, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:GETFONT(16)} context:nil];

    CGFloat textHight = textsize.size.height + 25;

    if (textHight > TextViewHeight) {

        contentTextView.est_height = textHight + 15;

    }else{

        contentTextView.est_height = TextViewHeight + 30;

    }*/
    
    
}


/**
 剩余输入字符数量:
 */
- (void) calculateRemainNum
{
    
    NSInteger remain = MaxContentNum - [XJPublishManager lenghtWithString:contentTextView.text];
    
    self.publishToolView.retainNumlab.text = [NSString stringWithFormat:@"%ld",remain];
    
}



/**
 发布:
 */
- (void) commitNewPost
{
    
    //没有图片,直接发布:
    if (self.picsArray.count == 0) {
        
    }else{
        
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
    
    
}


/**
 处理at;
 */
- (NSString*) dealWithAtUser
{
    
    NSString*commitString = contentTextView.text;
    
    //处理@;<s>为与后台约定标示,可为其他,后台可以解析标签获取即可:
    for (XJUser *user in self.atArray) {
        NSString *str = [NSString stringWithFormat:@"@%@",user.name];
        commitString = [commitString stringByReplacingOccurrencesOfString:str withString:[NSString stringWithFormat:@"<u>%@</u>",user.userId]];
        NSLog(@"%@",commitString);
    }
    
    NSString *content = [commitString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return content;
}

- (void) longPressPics:(UILongPressGestureRecognizer *)longPressGes
{
    
    // 禁止拖动加号:
    NSIndexPath *indexPath = [self.picsCollectonView indexPathForItemAtPoint:[longPressGes locationInView:self.picsCollectonView]];
    if (indexPath.row == self.picsArray.count +1 && self.picsArray.count < 9) {
        return;
    }
    
    switch (longPressGes.state) {
            
        case UIGestureRecognizerStateBegan: {
            
            // 如果点击的位置不是cell,break
            if (nil == indexPath) {
                break;
            }
            [self.picsCollectonView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            
            [self.picsCollectonView updateInteractiveMovementTargetPosition:[longPressGes locationInView:self.picsCollectonView]];
            break;
            
        case UIGestureRecognizerStateEnded:

            [self.picsCollectonView endInteractiveMovement];
            break;
            
        default:
            [self.picsCollectonView cancelInteractiveMovement];
            break;
    }
    
}

#pragma mark - photobrowser代理方法 -
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.picsArray[index];
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    return nil;
}

@end
