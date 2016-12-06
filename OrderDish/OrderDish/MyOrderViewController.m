//
//  MyOrderViewController.m
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderDatabase.h"
#import "MyOrderTableViewCell.h"
#import "MyDianCai.h"
#import "SongDanVC.h"
#import "orderViewController.h"
@interface MyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,JJBtnDelegate,UIAlertViewDelegate>

@end

@implementation MyOrderViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //注册cell
    [_tableview registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //获取order的数据
    _allOrder = [[MyOrderDatabase getOrderDatebase]retain];
    //计算总价
    [self jisuan];
    //监听系统键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:UIKeyboardWillHideNotification object:nil];

}
- (void)viewWillAppear:(BOOL)animated
{
    [self jisuan];
    [_tableview reloadData];
    
}
//计算
- (void)jisuan
{
    int sum = 0;
    for (MyDianCai * mc  in _allOrder)
    {
        sum += [mc.price intValue]*mc.Num;
    }
    _zongjia.text = [NSString stringWithFormat:@"%d",sum];
    
}
//协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allOrder.count;
  
}

//cell
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    
    MyDianCai * mc = _allOrder[indexPath.row];
    cell.ID.text = [NSString stringWithFormat:@"%d",indexPath.row +1];
    cell.name.text = mc.name;
    cell.price.text = mc.price;
    cell.zhonglei.text = mc.kind;
    cell.num.text = [NSString stringWithFormat:@"%d",mc.Num];
    //设置代理
    cell.DELEGATE = self;
    cell.backgroundColor = [UIColor clearColor];
    cell.beizhu.text = mc.remark;
    
    cell.indexpath = indexPath;
    return cell;
    
    
}

//删除按钮的文字
- (NSString * )tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return  @"×";
}

//删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyDianCai * mc = _allOrder[indexPath.row];
    
    [MyOrderDatabase deleteOrderDatabase:mc.ID];
    [_allOrder removeObject:mc];
    //计算
    [self jisuan];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
   
}


//加减方法
- (void)JJBtnClick:(int)tag andcell:(MyOrderTableViewCell * )cell
{
    NSIndexPath * indexpath = [_tableview indexPathForCell:cell];
    MyDianCai * mc = _allOrder[indexpath.row];
    int num = mc.Num;
    if (tag == 10)
    {
        num += 1;
        //更改数据库
        [MyOrderDatabase JJBtnUpdataData:mc andNum:num];
        //更改源数据
        mc.Num = num;
        
        
    }
    if(tag == 20)
    {
        if (num == 1)
        {
            return;
        }
        num -= 1;
        //更改数据库
        [MyOrderDatabase JJBtnUpdataData:mc andNum:num];
        //更改源数据
        mc.Num = num;
        
    }
    //计算
    [self jisuan];
    //刷新
    [_tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

//输入框
- (void)CellTextFieldSR:(int)tag andcell:(MyOrderTableViewCell *)cell andindexpath:(NSIndexPath *)indexpath
{
 
  
    MyDianCai * mc = _allOrder[indexpath.row];
    int num = [cell.num.text intValue];
    NSString * text = cell.beizhu.text;
    if (tag == 1)
    {
        //更改数据库
        [MyOrderDatabase CellTextFieldNum:mc andNum:num];
        //更改源数据
        mc.Num = num;
        //计算
        [self jisuan];
    }
    if (tag == 2)
    {
        //更改数据库
        [MyOrderDatabase CellTextFieldRemark:mc andRemark:text];
        //更改数据源
        mc.remark = text;
    }
    //刷新
    [_tableview reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];

  
    
}
//键盘通知方法
- (void)notification:(NSNotification *)noti
{
    if ([noti.name isEqualToString:@"UIKeyboardWillHideNotification"])
    {
        //设置表的偏移
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        return;
    }
    NSDictionary * dic = noti.userInfo;
    
    CGRect bounds = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float width = bounds.size.width;
    NSLog(@"%f",width);
    if (_tableview.bounds.size.height<width)
    {
        NSLog(@"%f",_tableview.bounds.size.height);
        return;
    }
    _tableview.contentInset = UIEdgeInsetsMake(0, 0,width , 0);
    
    
    
    
    
    
}

//退出按钮
- (IBAction)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//送单按钮
- (IBAction)songdan:(id)sender
{
    NSMutableArray * array = [MyOrderDatabase getOrderDatebase];
    NSLog(@"-----%d",array.count);
    if (array.count == 0)
    {
        NSLog(@"313156");
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有点菜！" delegate:self cancelButtonTitle:@"去点菜" otherButtonTitles:@"返回", nil];
        [alert show];
        [alert release];
        return;
    }

    SongDanVC * vc = [[SongDanVC alloc]init];
  
    [self presentViewController:vc animated:YES completion:nil];
   
}


//alertview协议方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        orderViewController * vc = self.navigationController.viewControllers[2];
        [self.navigationController popToViewController:vc animated:YES];
    }
    
    
    
}

//汇总按钮
- (IBAction)huizong:(id)sender
{
    
}

- (void)dealloc
{
    [_allOrder release];
    [_tableview release];
    [_zongjia release];
    [super dealloc];
}
@end
