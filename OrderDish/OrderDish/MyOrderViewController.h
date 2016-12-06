//
//  MyOrderViewController.h
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (retain, nonatomic) IBOutlet UILabel *zongjia;
@property (nonatomic,retain)NSMutableArray * allOrder;//所有的菜单数据

@end
