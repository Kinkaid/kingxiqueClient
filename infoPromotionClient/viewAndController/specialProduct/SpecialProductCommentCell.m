//
//  SpecialProductCommentCell.m
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SpecialProductCommentCell.h"
#import "CommentImageCollectionViewCell.h"
#define collectionViewCellId @"CommentImageCollectionViewCell"
extern CGFloat SCREEN_WIDTH;
@implementation SpecialProductCommentCell
{
    __weak IBOutlet UIImageView *_headerImg;
    
    __weak IBOutlet UILabel *_customerNameLabel;
    __weak IBOutlet UIImageView *_starLevelImg;
    
    __weak IBOutlet UILabel *_dateLabel;
    __weak IBOutlet UILabel *_commentLabel;
    
    __weak IBOutlet UILabel *_replyLabel;
    
    __weak IBOutlet NSLayoutConstraint *_collectionViewHeight;
    __weak IBOutlet NSLayoutConstraint *_replyTop;
}
- (void)awakeFromNib {
    // Initialization code
    [self initWithCollectionView];
}
-(void)initWithCollectionView
{
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    [self.imageCollectionView registerNib:[UINib nibWithNibName:collectionViewCellId bundle:nil] forCellWithReuseIdentifier:collectionViewCellId];
}
-(void)showDataWithDic:(NSDictionary *)dic
{
    self.imageListArr = dic[@"commentImgArr"];
    _headerImg.image = [UIImage imageNamed:dic[@"headerImgUrl"]];
    _customerNameLabel.text = dic[@"customerName"];
    _dateLabel.text = dic[@"date"];
    _commentLabel.text = dic[@"comment"];
    int i;
    for (i=0; i<[dic[@"reply"] length]; i++) {
        if ([[dic[@"reply"] substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"]" ]) {
            break;
        }
    }
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:dic[@"reply"]];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[TDColorUtil parse:@"#333333"] range:NSMakeRange(0, i+1)];
    _replyLabel.attributedText = attributeStr;
    switch ([dic[@"starLevel"] intValue]) {
        case 1:
        {
            _starLevelImg.image = [UIImage imageNamed:@"oneStar"];
        }
            break;
        case 2:
        {
            _starLevelImg.image = [UIImage imageNamed:@"twoStars"];
        }
            break;
        case 3:
        {
            _starLevelImg.image = [UIImage imageNamed:@"threeStars"];
        }
            break;
        case 4:
        {
            _starLevelImg.image = [UIImage imageNamed:@"fourStars"];
        }
            break;
        case 5:
        {
            _starLevelImg.image = [UIImage imageNamed:@"fiveStars"];
        }
            break;
            
        default:
            break;
    }
    if (self.imageListArr.count) {
        _collectionViewHeight.constant =(SCREEN_WIDTH-120)/4;
        _replyTop.constant = 10;
    }else{
        _collectionViewHeight.constant = 0;
        _replyTop.constant = 0;
    }
    [self.imageCollectionView reloadData];
}
#pragma mark - collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageListArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommentImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellId forIndexPath:indexPath];
    [cell showImage:self.imageListArr[indexPath.item]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-120)/4, (SCREEN_WIDTH-120)/4);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
       return UIEdgeInsetsMake(0, 0, 0, 15);
    }else if (section==1||section == 2){
       return UIEdgeInsetsMake(0, 15, 0, 15);
    }else {
        return UIEdgeInsetsMake(0, 15, 0, 0);
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate largeImageWithIndexPath:self.indexPath AndItem:indexPath.item];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
