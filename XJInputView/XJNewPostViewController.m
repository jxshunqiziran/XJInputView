//
//  XJNewPostViewController.m
//  XJTemplateProject
//
//  Created by 江鑫 on 2018/8/16.
//  Copyright © 2018年 XJ. All rights reserved.
//

#import "XJNewPostViewController.h"
#import "XJInputView.h"
#import "XJNewPostCollectionViewCell.h"
#import "XJItemSelView.h"
#import "XJFaceInputHelper.h"
#import "XJInputDefine.h"

@interface XJNewPostViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,XJItemSelDelegate,XJInputViewDelegate,UITextViewDelegate,TZImagePickerControllerDelegate,XJFaceEmojeVieDelegate>

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UICollectionView *picCollectionView;
@property (nonatomic, strong) XJItemSelView *inputView;
@property (nonatomic, strong) NSMutableArray *picsArray;
@property (nonatomic, strong) NSMutableAttributedString *contentAttributedText;

@end

static NSString *resueNewPostResueID = @"cell";

@implementation XJNewPostViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self setupNavBar];
}

- (void)setupNavBar
{
    self.navigationItem.title = @"发点啥呢";
}

- (void) setupView
{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.bgScrollView];
    
    [self.bgScrollView addSubview:self.contentTextView];
    
    [self.bgScrollView addSubview:self.picCollectionView];
    
    XJItemSelView*  _inputView = [XJItemSelView showInputViewInView:self.view itemSelfType:XJItemSelTypeMulitfuntion contentTextView:_contentTextView];
    _inputView.faceEmojeView.delegate = self;
    _inputView.mulitFuctionView.delegate = self;
    
    [self makeConstraint];
    
}

- (void)makeConstraint
{
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(XJScreenWidth);
        make.height.mas_equalTo(contentVieHeight);
    }];

    [self.picCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTextView.mas_bottom).offset(15);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(XJScreenWidth);
        make.height.mas_equalTo(400);
    }];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark ----- 懒加载 --------

- (UITextView*)contentTextView
{
    
    if (!_contentTextView) {
        
        UITextView *contentTextView = [[UITextView alloc]init];
//        contentTextView.placeholderText =  @"分享新鲜事...";
//        contentTextView.placeholderFont = GETFONT(16);
//        contentTextView.backgroundColor = [UIColor redColor];
        contentTextView.scrollEnabled = NO;
        contentTextView.delegate = self;

        contentTextView.font = GETFONT(16);
        contentTextView.textColor = contentThemeColor;
        contentTextView.textContainerInset = UIEdgeInsetsMake(10, 18, 10, 18);
        contentTextView.typingAttributes = [XJFaceInputHelper shareFaceHelper].attributes;
        _contentTextView = contentTextView;
        
    }
    return _contentTextView;
}

- (UIScrollView*)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, XJScreenWidth, XJScreenHeight-10)];
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        _bgScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _bgScrollView.delegate = self;
        _bgScrollView.contentSize = CGSizeMake(XJScreenWidth, XJScreenHeight);
        _bgScrollView.showsVerticalScrollIndicator = YES;
    }
    return _bgScrollView;
}

- (UICollectionView*)picCollectionView
{
    if (!_picCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 15;
        layout.sectionInset = UIEdgeInsetsMake(5, 25, 5, 25);
        layout.itemSize = CGSizeMake(SCALE_WIDTH(90), SCALE_WIDTH(95));
        
        _picCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _picCollectionView.delegate = self;
        _picCollectionView.dataSource = self;
        _picCollectionView.backgroundColor = [UIColor whiteColor];
        [_picCollectionView registerClass:[XJNewPostCollectionViewCell class] forCellWithReuseIdentifier:resueNewPostResueID];
        UILongPressGestureRecognizer *longPresssGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPics:)];
        [_picCollectionView addGestureRecognizer:longPresssGes];
    }
    return _picCollectionView;
}

- (NSMutableArray*)picsArray
{
    if (!_picsArray) {
        _picsArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _picsArray;
}


#pragma mark ------- UICollectionViewDelegate --------

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.picsArray.count == 0 || self.picsArray.count == MaxPicsNum) {
        return self.picsArray.count;
    }
    return self.picsArray.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XJNewPostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resueNewPostResueID forIndexPath:indexPath];
    cell.index = indexPath.row;
    
    if (indexPath.row == self.picsArray.count) {
        cell.picImgeView.image = GETIMG(@"btn_add");
        cell.deleteBtn.hidden = YES;
    }else{
        UIImage *picImage = self.picsArray[indexPath.row];
        cell.picImgeView.image = picImage;
        cell.deleteBtn.hidden = NO;
        WeakSelf(weakSelf);
        cell.deleteBtnClickBlock = ^(NSInteger index){
            [weakSelf.picsArray removeObjectAtIndex:index];
            [weakSelf.picCollectionView reloadData];
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.picsArray.count) {
        [self goTZImagePickerController];
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //如果移到添加按钮后面，就退出，不能移动
    NSInteger destinationRow = destinationIndexPath.row;
    if (destinationRow == self.picsArray.count) {
        return;
    }
    UIImage *picImage = self.picsArray[sourceIndexPath.item];
    [_picsArray removeObjectAtIndex:sourceIndexPath.row];
    [_picsArray insertObject:picImage atIndex:destinationIndexPath.row];
}


#pragma mark -------  TZImagePickerControllerDelegate ---

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto;
{
    
    [self.picsArray addObjectsFromArray:photos];
    [self.picCollectionView reloadData];
    
}


#pragma mark  --------  XJItemSelDelegate ----

- (void) xjFaceEmojeSelType:(publishSelType)type emojeString:(NSString*)emojeString;
{
    switch (type) {
        case publishSelTypeAt:{
        }
            break;
            
        case publishSelTypeFace:{
        }
            break;
            
        case publishSelTypePic:{
            [self.view endEditing:YES];
            [self goTZImagePickerController];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)goTZImagePickerController
{
    
    TZImagePickerController*pickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:(MaxPicsNum-self.picsArray.count) delegate:self];
    pickerVC.allowPickingVideo = NO;
    pickerVC.allowPickingOriginalPhoto = NO;//待商榷;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}
//这两处代理考虑写在里面;
#pragma mark  ----- XJFaceEmojeVieDelegate -----

- (void)faceViewClickHeightChanged
{
     [self adjustContentTextViewHeight];
}

#pragma mark  ------  UITextViewDelegate --------

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.inputView.mulitFuctionView.faceSelBtn.selected = NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self adjustContentTextViewHeight];
}

#pragma mark ------- Private-Method -------

/**
 调整文本显示的高度;
 */
- (void) adjustContentTextViewHeight
{
    
    CGSize newSize  = [_contentTextView sizeThatFits:CGSizeMake(XJScreenWidth,MAXFLOAT)];
    
    if (newSize.height > contentVieHeight) {
        [_contentTextView mas_updateConstraints:^(MASConstraintMaker *make){
            make.height.mas_equalTo(newSize.height);
        }];
    }
    
}

- (void) longPressPics:(UILongPressGestureRecognizer *)longPressGes
{
    // 禁止拖动加号:
    NSIndexPath *indexPath = [self.picCollectionView indexPathForItemAtPoint:[longPressGes locationInView:self.picCollectionView]];

    
    switch (longPressGes.state) {
        case UIGestureRecognizerStateBegan: {
            // 如果点击的位置不是cell,break
            if (indexPath.row == self.picsArray.count) {
                return;
            }
            if (nil == indexPath) {
                break;
            }
            [self.picCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
            
        case UIGestureRecognizerStateChanged:
            [self.picCollectionView updateInteractiveMovementTargetPosition:[longPressGes locationInView:self.picCollectionView]];
            break;
            
        case UIGestureRecognizerStateEnded:
            if (indexPath.row == self.picsArray.count) {
                [self.picCollectionView cancelInteractiveMovement];
                return;
            }
            [self.picCollectionView endInteractiveMovement];
            break;

        default:
            [self.picCollectionView cancelInteractiveMovement];
            break;
    }
}


//- (void) adjustContentTextViewHeight
//{
//    YYTextLinePositionSimpleModifier *modifier = [YYTextLinePositionSimpleModifier new];
//    modifier.fixedLineHeight = 24;
//
//    YYTextContainer *container = [YYTextContainer new];
//    container.size = CGSizeMake(XJScreenWidth - 36, CGFLOAT_MAX);
//    container.linePositionModifier = modifier;
//
//    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:_contentTextView.attributedText];
//    CGFloat textHeight = layout.textBoundingSize.height +  heightSpace;
//
//    if (textHeight > contentVieHeight) {
//
//        [_contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(textHeight + heightSpace + 15);
//        }];
//
//    }else{
//        [_contentTextView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(contentVieHeight);
//        }];
//    }
//
//}
@end
