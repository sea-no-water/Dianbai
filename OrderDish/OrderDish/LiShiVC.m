//
//  LiShiVC.m
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "LiShiVC.h"
#import "LSVCCell.h"
#import "room_recordTableDatebase.h"
#include "recordTableDatebase.h"
#import "room_recordTable.h"
#import "ChaXunVC.h"
@interface LiShiVC ()<UITableViewDataSource,UITableViewDelegate,btnDelegate>
@property (nonatomic,retain)NSMutableArray * allRoomData;
@end

@implementation LiShiVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);

    //获取room数据
    _allRoomData = [[room_recordTableDatebase getRoomData]retain];


}

//退出
- (IBAction)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return _allRoomData.count;

}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     LSVCCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"LSVCCell" owner:self options:nil];
        cell = array.firstObject;
    }
 
    room_recordTable * room = _allRoomData[indexPath.row];
    cell.count.text = [NSString stringWithFormat:@"%d",indexPath.row];
    cell.date.text = room.data;
    cell.time.text = room.time;
    cell.room.text = room.room;
    cell.Btndelegate = self;
    return cell;
    
    
    
}
//清空

- (IBAction)qingkong:(UIButton *)sender
{
    [recordTableDatebase deleteAllData];
    [room_recordTableDatebase deleteAllData];
    [_allRoomData removeAllObjects];

    NSIndexSet * set = [NSIndexSet indexSetWithIndex:0];
    [_tableview reloadSections:set withRowAnimation:UITableViewRowAnimationTop];

}

//按钮代理方法
- (void)buttonClick:(LSVCCell *)cell andtag:(int)tag
{
    NSIndexPath * indexpath = [_tableview indexPathForCell:cell];
    room_recordTable * room = _allRoomData[indexpath.row];
    if (tag == 0)
    {
        //删除数据库数据
        [room_recordTableDatebase deleteDateWithRoom:room];
        [recordTableDatebase deleteDataWithGroupID:room];
        
        //删除数据源数据
        [_allRoomData removeObjectAtIndex:indexpath.row];
        //删除行
        [_tableview deleteRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationLeft];
        //刷新区
        NSIndexSet * set = [NSIndexSet indexSetWithIndex:indexpath.section];
        [_tableview reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    if (tag == 1)
    {
       
        ChaXunVC * vc = [[ChaXunVC alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        
        [vc release];
    }
    
}



- (void)dealloc {
    [_allRoomData release];
    [_tableview release];
    [super dealloc];
}
@end
