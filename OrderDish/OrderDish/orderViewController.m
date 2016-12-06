//
//  orderViewController.m
//  OrderDish
//
//  Created by mac on 16/7/16.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "orderViewController.h"
#import "TableViewCell.h"
#import "FirstViewController.h"
#import "secendViewController.h"
@interface orderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _array_n;
    NSMutableArray * _array_s;
    UIButton * _selectBtn;//记录点击的按钮
    FirstViewController * _vc;
    secendViewController * _vc1;
}
@end

@implementation orderViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
      //表
    [self creatTableview];
//    //默认视图
    _vc = [[FirstViewController alloc]init];
    _vc1 = [[secendViewController alloc]init];

    [self vc];
    
    
  }
- (void)vc
{
    //添加为子视图
  
    [self addChildViewController:_vc];
    _vc.view.frame = CGRectMake(0, 0, 967, 768);
    [self.view addSubview:_vc.view];
    
}

- (void)vc1
{
    //把secend视图作为子视图
    [self addChildViewController:_vc1];
    _vc1.view.frame = CGRectMake(0, 0, 967, 768);
    [self.view addSubview:_vc1.view];
 
}
#pragma mark  选项表
//tableview
- (void)creatTableview
{
    self.TableViewCZ.delegate = self;
    self.TableViewCZ.dataSource = self;
    self.TableViewCZ.backgroundColor = [UIColor lightGrayColor];
    self.TableViewCZ.rowHeight = 100;
    self.TableViewCZ.backgroundColor = [UIColor clearColor];
    self.TableViewCZ.separatorStyle = UITableViewCellSeparatorStyleNone;
    _array_n = [[NSMutableArray array]retain];
    _array_s = [[NSMutableArray array]retain];
    for (int i = 0; i<7; i++)
    {
        NSString * imgname_n = [NSString stringWithFormat:@"%d_n.png",i];
        UIImage * image_n = [UIImage imageNamed:imgname_n];
        [_array_n addObject:image_n];
        NSString * imgname_s = [NSString stringWithFormat:@"%d_s.png",i];
        UIImage * image_s = [UIImage imageNamed:imgname_s];
        [_array_s addObject:image_s];
        
    }

}

//协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

//cell
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil];
        cell = (TableViewCell *)array.firstObject;
        cell.backgroundColor = [UIColor clearColor];
        [cell.button addTarget:self action:@selector(buttonClick:events:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    if (indexPath.row == 0)
    {
        cell.button.selected = YES;
        _selectBtn = [cell.button retain];
    }
    [cell.button setImage:_array_n[indexPath.row] forState:UIControlStateNormal];
    [cell.button setImage:_array_s[indexPath.row] forState:UIControlStateSelected];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 

    return cell;
}

//按钮方法
- (void)buttonClick:(UIButton * )button events:(UIEvent * )event
{
    if (_selectBtn == button)
    {
        return;
    }
    _selectBtn.selected = !_selectBtn.selected;
    button.selected = !button.selected;
    [_selectBtn release];
    _selectBtn = [button retain];
    

    //获取点击按钮在那个cell
    //获取点击的对象
    UITouch * touch  = event.allTouches.anyObject;
    //获取点击的对象，相对于某一个视图的点
    CGPoint point = [touch locationInView:_TableViewCZ];
    //根据相对的点，相对于tableview的位置，找到indexpath
    NSIndexPath * indexpath = [_TableViewCZ indexPathForRowAtPoint:point];
    
    //设置背景图片
    if (indexpath.row == 0)
    {
        _bgImg.image = [UIImage imageNamed:@"bgp3"];
        [self vc];
        [self.view bringSubviewToFront:_vc.view];
        [self.view sendSubviewToBack:_vc1.view];
        
        
    }
    else
    {
        _bgImg.image = [UIImage imageNamed:@"bgp4"];
        [self vc1];
        [self.view bringSubviewToFront:_vc1.view];
        [self.view sendSubviewToBack:_vc.view];
        
        //把点击的indexpath通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"INDEXPATH" object:nil userInfo:@{@"indexpath":indexpath}];
    }
    
    
}
//返回按钮
- (IBAction)exit:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 菜单表


- (void)dealloc {

    [_vc release];
    [_vc1 release];
    [_selectBtn release];
    [_array_n release];
    [_array_s release];
    [_TableViewCZ release];
  
    [_bgImg release];
    [super dealloc];
}
@end
