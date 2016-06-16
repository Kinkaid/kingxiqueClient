//
//  CommentLargeImgController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/26.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "CommentLargeImgController.h"

@interface CommentLargeImgController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@end
extern CGFloat SCREEN_WIDTH;
extern CGFloat SCREEN_HEIGHT;
@implementation CommentLargeImgController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initWithScrollView];
}
-(void)initWithScrollView
{
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.imgArr.count, SCREEN_WIDTH);
    for (int i=0; i<self.imgArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH *i, SCREEN_HEIGHT/5, SCREEN_WIDTH, self.view.frame.size.width)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",IMAGEURL,self.imgArr[i]]]];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        [imageView addGestureRecognizer:tap];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentOffset =CGPointMake(SCREEN_WIDTH*self.currentPage, 0);
     self.pageLabel.text = [NSString stringWithFormat:@"%d/%ld",self.currentPage+1,self.imgArr.count];
}
-(void)singleTap:(UITapGestureRecognizer *)singleTap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageLabel.text = [NSString stringWithFormat:@"%.0f/%ld",scrollView.contentOffset.x/SCREEN_WIDTH+1,self.imgArr.count];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
