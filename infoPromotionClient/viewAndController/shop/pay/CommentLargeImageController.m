//
//  CommentLargeImageController.m
//  infoPromotionClient
//
//  Created by zhujingci on 15/12/25.
//  Copyright © 2015年 tuda. All rights reserved.
//

#import "CommentLargeImageController.h"

@interface CommentLargeImageController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *largeImageView;


@end

@implementation CommentLargeImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setImageView{
    [self.largeImageView sd_setImageWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@/%@",IMAGEURL,self.commentImage.imageStr]]];
}
#pragma mark -IBActions
//返回
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//删除
- (IBAction)deleteAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    [alertView show];
}
#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {//删除
        [self.delegate deleteCommentLargeImage:self.indexPath.row];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
