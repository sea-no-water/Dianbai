//
//  FirstViewController.m
//  OrderDish
//
//  Created by mac on 16/7/18.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "FirstViewController.h"
#import "menuTableViewCell.h"
#import "MenuDatabase.h"
#import "Group.h"
#import "ImageScrollView.h"
#import "XiangQingVC.h"
#import "diancaiDatebase.h"
#import "MyOrderViewController.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    
    NSMutableArray * _headName;//group数据
    NSMutableArray * _menuArray;//menu数据
    NSMutableArray * _isopen;//存放bool值
    NSIndexPath *  _isselecet;//记录上次点击的区

    
}

@property (retain, nonatomic) IBOutlet ImageScrollView *TPSC;

@end

@implementation FirstViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //默认第一区显示
    _isselecet =  [[NSIndexPath indexPathForRow:0 inSection:0]retain];
    _isopen = [[NSMutableArray arrayWithObjects:@"YES",@"NO",@"NO",@"NO",@"NO", nil]retain];
    _headName = [[NSMutableArray alloc]init];
    _menuArray = [[NSMutableArray alloc]init];
    //菜单tableview
    self.menuTable.delegate = self;
    self.menuTable.dataSource = self;
    _menuTable.backgroundColor = [UIColor clearColor];
    _menuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //获取group的数据
    [self headname];
    //获取menu的数据
    [self menuTableDatabse];
    //滚动视图的图片.默认显示第一区
    [self.TPSC showImageWithArray:_menuArray.firstObject];
    

}
//

//获取的groupdatabase数据 区头
- (void)headname
{
  NSString * str = [MenuDatabase selectGroupTableDatabase:@"主厨推荐"];

    //剪切获得的字符串
    NSRange range1 = {0,1};
    NSString * str1 = [str substringWithRange:range1];
    NSRange range2 = {2,1};
    NSString * str2 = [str substringWithRange:range2];
    NSRange range3 = {4,1};
    NSString * str3 = [str substringWithRange:range3];
    NSRange range4 = {6,1};
    NSString * str4 = [str substringWithRange:range4];
    NSRange range5 = {8,1};
    NSString * str5 = [str substringWithRange:range5];
    [_headName addObject:str1];
    [_headName addObject:str2];
    [_headName addObject:str3];
    [_headName addObject:str4];
    [_headName addObject:str5];
    
}
//获取menuTable数据
- (void)menuTableDatabse
{
    NSMutableArray * array = [MenuDatabase selectMenutableDatabase:1];
    NSMutableArray * array1 = [NSMutableArray array];
    NSMutableArray * array2 = [NSMutableArray array];
    NSMutableArray * array3 = [NSMutableArray array];
    NSMutableArray * array4 = [NSMutableArray array];
    NSMutableArray * array5 = [NSMutableArray array];
    for (Group * group in array)
    {
        if ([group.iKind isEqualToString:@"鲍"])
        {
            [array1 addObject:group];
        }
        if ([group.iKind isEqualToString:@"参"])
        {
            [array2 addObject:group];
        }
        if ([group.iKind isEqualToString:@"翅"])
        {
            [array3 addObject:group];
        }
        if ([group.iKind isEqualToString:@"燕"])
        {
            [array4 addObject:group];
        }
        if ([group.iKind isEqualToString:@"胶"])
        {
            [array5 addObject:group];
        }
        
    }
    [_menuArray addObject:array1];
    [_menuArray addObject:array2];
    [_menuArray addObject:array3];
    [_menuArray addObject:array4];
    [_menuArray addObject:array5];
}
#pragma mark 协议方法
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_isopen[section] boolValue] == NO)
        
    {
        return 0 ;
    
    }

       return [_menuArray[section] count];
}

//cell
- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    menuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray * array = [[NSBundle mainBundle]loadNibNamed:@"menuTableViewCell" owner:nil options:nil];
        cell = (menuTableViewCell * )array.firstObject;
        cell.menuCellfontLb.textColor = [UIColor yellowColor];
        cell.menuCellLbbelow.textColor = [UIColor yellowColor];
        cell.menuCellLbbelow.textAlignment = NSTextAlignmentRight;

    }
    cell.backgroundColor = [UIColor clearColor];
   // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置每行的显示
    Group * group = _menuArray[indexPath.section][indexPath.row];
    cell.menuCellfontLb.text = group.name;
    cell.menuCellLbbelow.text = [NSString stringWithFormat:@"%d/%@",group.price,group.unit];
    
    
    
    
    
    return cell;
}

//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _headName.count;
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
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //使文字距离边框保持一定像素
        button.contentEdgeInsets = UIEdgeInsetsMake(10, 80, 0, 0);
        
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
        
        [button release];
        [image release];
    }
    //根据tag值获取button
    UIButton * button = (UIButton *)[header viewWithTag:10];
    [button setTitle:_headName[section] forState:UIControlStateNormal];
    
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
    [_menuTable reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
   
    
    [_isselecet release];
    _isselecet = [[NSIndexPath indexPathForRow:0 inSection:section] retain];
    
    //动画
    menuTableViewCell * cell = (menuTableViewCell *)[_menuTable cellForRowAtIndexPath:_isselecet];
    
    [self performSelector:@selector(cellAnimation:) withObject:cell afterDelay:0.5];
    
    
    
    //重新设置展示的图片
    [self.TPSC showImageWithArray:_menuArray[_isselecet.section]];
    
    
}

//点击cell的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_isselecet release];
    _isselecet = [indexPath retain];
    [self.TPSC setContentOffset:CGPointMake(self.TPSC.bounds.size.width*_isselecet.row, 0) animated:YES];
    
    //动画
    menuTableViewCell * cell = (menuTableViewCell *)[_menuTable cellForRowAtIndexPath:_isselecet];
    [self cellAnimation:cell];
    
    NSLog(@"%d---%d",indexPath.section,indexPath.row);
    
}

//滚动减速的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (self.TPSC.tag == 10)
    {
        int row = scrollView.contentOffset.x/scrollView.bounds.size.width;
        int section = _isselecet.section;
        //更改当前显示的tableview上的indexPath
        [_isselecet release];
        _isselecet = [[NSIndexPath indexPathForRow:row inSection:section] retain];;
        
        //动画
        menuTableViewCell * cell = (menuTableViewCell *)[_menuTable cellForRowAtIndexPath:_isselecet];
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

//详情按钮
- (IBAction)xiangqingBtn:(id)sender
{
    XiangQingVC * vc = [[XiangQingVC alloc]init];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    vc.group = _menuArray[_isselecet.section][_isselecet.row];
    
    
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
    
}
//点菜按钮
- (IBAction)diancaiBtn:(id)sender
{
    Group * gp = _menuArray[_isselecet.section][_isselecet.row];
    [diancaiDatebase insertOrderWithGroup:gp];
}
//我的菜单按钮
- (IBAction)MyDiancaiBtn:(id)sender
{
    
    MyOrderViewController * vc = [[MyOrderViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
    
    
    
}




- (void)dealloc
{
    [_isopen release];
    [_isselecet release];
    [_menuArray release];
    [_headName release];
    [_menuTable release];
    [_circleImage release];
    [_TPSC release];

    [super dealloc];
    
    
}
@end
