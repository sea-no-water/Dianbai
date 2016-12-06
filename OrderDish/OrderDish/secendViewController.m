//
//  secendViewController.m
//  OrderDish
//
//  Created by mac on 16/7/18.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "secendViewController.h"
#import "MenuDatabase.h"
#import "Group.h"
#import "menuTableViewCell.h"
#import "ImageScrollView.h"
#import "XiangQingVC.h"
#import "diancaiDatebase.h"
#import "MyOrderViewController.h"
@interface secendViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    
    NSMutableArray * _headName;//group数据
    NSArray * _name;//group的name
    NSMutableArray * _menuArray;//menu数据
    NSMutableArray * _isopen;//存放bool值
    NSIndexPath *  _isselecet;//记录上次点击的区
}
@property (nonatomic,retain)NSIndexPath * indexpath;//接受通知的indexpath
@property (nonatomic,retain)NSMutableArray * alldates;//获取group数据库的菜名
@property (nonatomic,retain)NSMutableArray * allMenudate;//获取menu的数据



@end

@implementation secendViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //默认第一区显示
    _isselecet =  [[NSIndexPath indexPathForRow:0 inSection:0]retain];
    _isopen = [[NSMutableArray arrayWithObjects:@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",  nil]retain];
    _headName = [[NSMutableArray alloc]init];
    _menuArray = [[NSMutableArray alloc]init];
    //接受通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification :) name:@"INDEXPATH" object:nil];
    //获取grouptable的数据
   _alldates = [[MenuDatabase getAllGroups]retain];
    
}


//通知的方法
- (void)notification:(NSNotification *)noti
{
    //初始化点击状态和开关状态
    [_isopen release];
    _isopen = [[NSMutableArray arrayWithObjects:@"YES",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",@"NO",  nil]retain];
    [_isselecet release];
    _isselecet =  [[NSIndexPath indexPathForRow:0 inSection:0]retain];

    //获取点击的菜单的按钮的indexPath
    NSDictionary * dic = noti.userInfo;
    [_indexpath release];
    _indexpath = [dic[@"indexpath"]retain];
 
    //获取group的name并切割
    Group * gp = _alldates[_indexpath.row];
    _name = [[gp.name componentsSeparatedByString:@"|"]retain];
    //获取menutable的数据
   _allMenudate = [[MenuDatabase getMenusWithGroup:gp]retain];
    //设置左上角的图片
    _LTimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dicon",_indexpath.row+1]];
    //设置滚动视图显示的图片
    [self.TPSC showImageWithArray:_allMenudate.firstObject];
    
    //刷新
    [_menuTable reloadData];
    NSLog(@"%d",_indexpath.row);
    
    [_indexpath release];
    _indexpath = [[NSIndexPath indexPathForRow:0 inSection:0]retain];
}


//tableview协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_isopen[section] boolValue] == NO)
    {
        return 0;
    }
    return  [_allMenudate[section] count];
    
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    menuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"menuTableViewCell" owner:nil options:nil];
        cell = (menuTableViewCell * )array.firstObject;
        cell.menuCellfontLb.textColor = [UIColor yellowColor];
        cell.menuCellLbbelow.textColor = [UIColor yellowColor];
        cell.menuCellLbbelow.textAlignment = NSTextAlignmentRight;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    Group * gp = _allMenudate[indexPath.section][indexPath.row];
    cell.menuCellfontLb.text = gp.name;
    cell.menuCellLbbelow.text = [NSString stringWithFormat:@"%d/%@",gp.price,gp.unit];
    if (indexPath.row == 0)
    {
        [self cellAnimation:cell];
    }
    return cell;
    
    
}
//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _name.count;
    
}
//区头
- (UIView * )tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    UITableViewHeaderFooterView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"head"];
    if (header == nil)
    {
        header = [[[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"head"]autorelease];
        
        //按钮
        UIButton * button = [[UIButton alloc]init];
        button.tag = 10;
        button.frame = CGRectMake(0, 0, 307, 44);
        [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        //按钮字体居左
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        //使文字距离边框保持一定像素
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 180);
        
        button.titleLabel.font = [UIFont systemFontOfSize:24];
        [button addTarget:self action:@selector(HeaderBtn: ) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:button];
        
        //图片
        UIImageView * image = [[UIImageView alloc]init];
        image.frame = CGRectMake(0, 14, 157, 30);
        image.image = [UIImage imageNamed:@"line33"];
        [button addSubview:image];
        
        //设置区头为透明
        header.layer.backgroundColor = [UIColor brownColor].CGColor;
        
    }
    
    //根据tag值获取button
    UIButton * button = (UIButton *)[header viewWithTag:10];
    [button setTitle:_name[section] forState:UIControlStateNormal];
    header.contentView.backgroundColor = [UIColor colorWithRed:32/255.0 green:23/255.0 blue:16/255.0 alpha:1 ];
    
    header.tag = section;
    return header;
}
//区头按钮方法
- (void)HeaderBtn:(UIButton * )button
{
    
    //把上次点击的区设为no
    _isopen[_isselecet.section] = @"NO";
    UITableViewHeaderFooterView * header = (UITableViewHeaderFooterView * )button.superview;
    
    int section = header.tag;
    BOOL isindex = [_isopen[section] boolValue];
    _isopen[section] = @(!isindex);
    
    if (_isselecet.section == section)
    {
        return;
    }
    //刷新
    NSMutableIndexSet * set = [NSMutableIndexSet indexSet];
    [set addIndex:_isselecet.section];
    [set addIndex:section];
    
    [_isselecet release];
    _isselecet = [[NSIndexPath indexPathForRow:0 inSection:section] retain];

    //要显示的图片
    [self.TPSC showImageWithArray:_allMenudate[_isselecet.section]];
    //动画
    menuTableViewCell * cell = (menuTableViewCell *)[self.menuTable cellForRowAtIndexPath:_isselecet];
    [self cellAnimation:cell];
    
    [_menuTable reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
}
//点击cell 的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.TPSC setContentOffset:CGPointMake(self.TPSC.bounds.size.width*indexPath.row, 0) animated:YES];
    //动画
    menuTableViewCell * cell = (menuTableViewCell * )[tableView cellForRowAtIndexPath:indexPath];
    [self cellAnimation:cell];
    [_isselecet release];
    _isselecet = [indexPath retain];
    
}
//滚动视图的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 10)
    {
        //获取当前图片对应的indexPath值
        int row = self.TPSC.contentOffset.x/self.TPSC.bounds.size.width;
        int section = _isselecet.section;
        [_isselecet release];
        _isselecet = [[NSIndexPath indexPathForRow:row inSection:section]retain];
        
        menuTableViewCell * cell = (menuTableViewCell *)[self.menuTable cellForRowAtIndexPath:_isselecet];
        [self cellAnimation:cell];
        
        
        
        }
    
    
}
//cell的动画
- ( void)cellAnimation:(UIView * )cell
{
    [UIView  beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:1 forView:cell cache:YES];
    [UIView commitAnimations];

}


//详情
- (IBAction)xiangqing:(id)sender
{
    XiangQingVC * vc = [[XiangQingVC alloc]init];
    
    vc.group = _allMenudate[_isselecet.section][_isselecet.row];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
}
//点菜
- (IBAction)diancai:(id)sender
{
    Group * gp = _allMenudate[_isselecet.section][_isselecet.row];
    [diancaiDatebase insertOrderWithGroup:gp];
    
}
//我的菜单
- (IBAction)myorder:(id)sender
{
    MyOrderViewController * vc = [[MyOrderViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
    
}

- (void)dealloc
{
    [_menuTable release];
    [_isopen release];
    [_isselecet release];
    [_name release];
    [_menuArray release];
    [_headName release];
    [_indexpath release];
    [_LTimage release];
    [_TPSC release];
    [_alldates release];
    [_allMenudate release];
    [super dealloc];
}

@end
