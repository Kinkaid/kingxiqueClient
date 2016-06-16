//
//  PaySuccessController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/24.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "PaySuccessController.h"
#import "PaySuccessCommentImageCell.h"
#import "CommentLargeImageController.h"

#define rateButtonMinTag 11
#define paySuccessCommentImageCellId @"PaySuccessCommentImageCell"
#define photoMaxNum 4

@interface PaySuccessController ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CommentLargeImageControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *payOfCardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardBalanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTextViewSuggest;

@property (weak, nonatomic) IBOutlet UICollectionView *commentImageCollection;


@end

NSMutableArray *_commentImageList;
@implementation PaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationStyle];
    [self initCollectionView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -private
-(void)setNavigationStyle{
    self.title = @"支付完成";
    self.navigationController.navigationBar.translucent = YES;
}
-(void)initCollectionView{
    [self.commentImageCollection registerNibByCellId:paySuccessCommentImageCellId];
}
-(void)loadData{
    _commentImageList = [[NSMutableArray alloc] init];
    CommentImageEntity *commentImage = [[CommentImageEntity alloc] init];
    commentImage.isCamera = YES;
    [_commentImageList addObject:commentImage];
    [self.commentImageCollection reloadData];
}
//拍照或从相册中选择
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
    }
}
#pragma mark -IBActions
- (IBAction)rateAction:(id)sender {
    UIButton *curButton = (UIButton *)sender;
    NSInteger curTag = curButton.tag;
    for (NSInteger i=rateButtonMinTag; i<=curTag;i++) {
        UIButton *rateButton = [self.view viewWithTag:i];
        [rateButton setImage:[UIImage imageNamed:@"star-select"] forState:UIControlStateNormal];
    }
    for (NSInteger i=curTag+1; i<=rateButtonMinTag+4;i++) {
        UIButton *rateButton = [self.view viewWithTag:i];
        [rateButton setImage:[UIImage imageNamed:@"star-noselect"] forState:UIControlStateNormal];
    }
}

#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        self.commentTextViewSuggest.hidden = YES;
    }else{
        self.commentTextViewSuggest.hidden = NO;
    }
}
#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _commentImageList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PaySuccessCommentImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:paySuccessCommentImageCellId forIndexPath:indexPath];
    CommentImageEntity *commentImage = _commentImageList[indexPath.row];
    [cell showCellWithImageEntity:commentImage];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CommentImageEntity *commentImage = _commentImageList[indexPath.row];
    if (commentImage.isCamera) {//拍照
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"您还可以上传%lu张图",photoMaxNum-_commentImageList.count+1] delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
        [actionSheet showInView:self.view];
    }else{//查看大图
        CommentLargeImageController *ctrl = [[CommentLargeImageController alloc] init];
        ctrl.commentImage = commentImage;
        ctrl.indexPath = indexPath;
        ctrl.delegate = self;
        [self presentViewController:ctrl animated:YES completion:nil];
    }
}
#pragma mark -UIImagePickerControllerDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {//拍照
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
    }else if(buttonIndex ==1){//从相册选取
        [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

#pragma mark -拍照或相册选取完成 委托
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [UIImage imageWithData:UIImageJPEGRepresentation(image, 0.5f)];
    [TDImageUtil uploadImage:image imageType:nil mainFileName:@"comment" attributes:nil success:^(NSDictionary *data) {
        CommentImageEntity *commentImage = [[CommentImageEntity alloc] init];
        commentImage.imageStr = data[@"url"];
        commentImage.isCamera = NO;
        [_commentImageList insertObject:commentImage atIndex:_commentImageList.count-1];
        if (_commentImageList.count==photoMaxNum+1) {
            [_commentImageList removeObjectAtIndex:_commentImageList.count-1];
        }
        [self.commentImageCollection reloadData];
    } fail:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -查看大图删除图片 委托
-(void)deleteCommentLargeImage:(NSUInteger)arrayIndex{
    [_commentImageList removeObjectAtIndex:arrayIndex];
    CommentImageEntity *lastCommentImage = _commentImageList[_commentImageList.count-1];
    if (!lastCommentImage.isCamera) {//若最后一个不是照相机
        CommentImageEntity *commentImage = [[CommentImageEntity alloc] init];
        commentImage.isCamera = YES;
        [_commentImageList addObject:commentImage];
    }
    [self.commentImageCollection reloadData];
}
- (IBAction)commitAction:(id)sender {
}

@end
