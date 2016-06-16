//
//  PrivilegeListCell.m
//  infoPromotionClient
//
//  Created by imac on 16/1/4.
//  Copyright © 2016年 tuda. All rights reserved.
//

#import "PrivilegeListCell.h"
#import "PrivilegeCommentCell.h"
@implementation PrivilegeListCell

- (void)awakeFromNib {
    // Initialization code
    [self initWithTableView];
    
}
-(void)initWithTableView{
    [self.commentTableView registerNibByCellId:@"PrivilegeCommentCell"];
    self.commentTableView.delegate = self;
    self.commentTableView.dataSource = self;
    self.commentTableView.scrollEnabled = YES;
    self.privilegeListTableView.delegate = self;
    self.privilegeListTableView.dataSource = self;
    self.privilegeListTableView.scrollEnabled = YES;
}
#pragma mark -- tableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.commentTableView) {
        PrivilegeCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"PrivilegeCommentCell" forIndexPath:indexPath];
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return commentCell;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArr.count;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
