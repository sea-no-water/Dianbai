//
//  ChaXunVC.m
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "ChaXunVC.h"
#import "recordTable.h"
#import "recordTableDatebase.h"
#import "MyOrderTableViewCell.h"
@interface ChaXunVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSMutableArray * allData;
@end

@implementation ChaXunVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
   _allData = [[recordTableDatebase selectRecorderTableData]retain];
    
    [_tableview registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableview.backgroundColor = [UIColor clearColor];
    //计算
    [self jisuan];
}

//计算
- (void)jisuan
{
    int sum = 0;
    for (recordTable * ret in _allData)
    {
        sum += [ret.menuPrice intValue]*ret.menuNum;
    }
    _zongjia.text = [NSString stringWithFormat:@"%d",sum];
    
}

//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allData.count;
    
}

//cell
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor clearColor];
    recordTable * ret = _allData[indexPath.row];
    cell.ID.text = [NSString stringWithFormat:@"%d",indexPath.row];
    cell.name.text = ret.menuName;
    cell.price.text = ret.menuPrice;
    cell.zhonglei.text = ret.menuKind;
    cell.num.text = [NSString stringWithFormat:@"%d",ret.menuNum];
     //设置输入框的可输入性
    [cell.num setEnabled:NO];
    cell.beizhu.text = ret.menuRemark;
    [cell.beizhu setEnabled:NO];
    
    return cell;
 
}




//退出
- (IBAction)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc {
    [_allData release];
    [_tableview release];
    [_zongjia release];
    [super dealloc];
}
@end
