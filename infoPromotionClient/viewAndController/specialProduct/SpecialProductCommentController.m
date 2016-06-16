//
//  SpecialProductCommentController.m
//  infoPromotionClient
//
//  Created by imac on 16/2/23.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "SpecialProductCommentController.h"
#import "SpecialProductCommentCell.h"
#import "CommentLargeImgController.h"
#define cellMarginHeight @"82"
#define cellId @"SpecialProductCommentCell"
@interface SpecialProductCommentController ()<UITableViewDataSource,UITableViewDelegate,largeImageDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)NSMutableArray *cellDataArr;
@end
extern CGFloat SCREEN_WIDTH;
@implementation SpecialProductCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNav];
    [self initWithTableView];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initWithNav
{
    self.title = @"评论(224)";
}
-(void)initWithTableView
{
    [self.tableView registerNibByCellId:cellId];
}
-(void)loadData
{
    NSMutableArray *imageListArr =[[NSMutableArray alloc]initWithObjects:@"comment/2016/2/b3d1ae5ce2452fd34e25c196751f3740_638X478.jpg",@"specialproduct/2016/2/3fdcfe2bd90b2108825c8121658d1757_640X638.jpg",@"comment/2016/2/a70098915d65ceefc297c915d7d6cac4_638X478.jpg",@"comment/2016/2/d0040f92df1fdfaa5168946b82f28964_638X478.jpg",nil];
    NSDictionary *cellDic = @{@"headerImgUrl":@"touxiang",@"customerName":@"Kinkaid Lau",@"starLevel":@(3),@"comment":@"嘎嘎~这么好吃的餐厅,环境不错,就餐时还有舒缓的音乐,服务很周到,下次还会再来嗨",@"date":@"2016.2.23 13:12",@"commentImgArr":imageListArr,@"reply":@"[店家] 谢谢亲的大力支持谢谢亲的大力支持,谢谢亲的大力支持,谢谢亲的大力支持,谢谢亲的大力支持"};
    self.cellDataArr = [[NSMutableArray alloc]initWithObjects:cellDic,cellDic,nil];
    [self.tableView reloadData];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.cellDataArr[indexPath.row][@"commentImgArr"] count]) {
       return [cellMarginHeight floatValue]+[LJKHelper textHeightFromTextString:self.cellDataArr[indexPath.row][@"comment"] width:SCREEN_WIDTH-32 fontSize:13]+(self.view.frame.size.width-120)/4+10+[LJKHelper textHeightFromTextString:self.cellDataArr[indexPath.row][@"reply"]  width:SCREEN_WIDTH-30 fontSize:13];
    }else{
       return [cellMarginHeight floatValue]+[LJKHelper textHeightFromTextString:self.cellDataArr[indexPath.row][@"comment"] width:SCREEN_WIDTH-32 fontSize:13]+[LJKHelper textHeightFromTextString:self.cellDataArr[indexPath.row][@"reply"]  width:SCREEN_WIDTH-30 fontSize:13];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialProductCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell showDataWithDic:self.cellDataArr[indexPath.row]];
    return cell;
}

//查看大图
-(void)largeImageWithIndexPath:(NSIndexPath *)indexPath AndItem:(NSInteger)item
{
    CommentLargeImgController *vc = [[CommentLargeImgController alloc]init];
    vc.imgArr =self.cellDataArr[indexPath.row][@"commentImgArr"];
    vc.currentPage = (int)item;
    [self presentViewController:vc animated:YES completion:nil];
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
