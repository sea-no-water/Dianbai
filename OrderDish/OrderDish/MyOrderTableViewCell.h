//
//  MyOrderTableViewCell.h
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>
//声明协议
@protocol JJBtnDelegate;

@interface MyOrderTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UILabel *ID;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *zhonglei;
@property (retain, nonatomic) IBOutlet UITextField *num;
//备注
@property (retain, nonatomic) IBOutlet UITextField *beizhu;
//减号
@property (retain, nonatomic) IBOutlet UIButton *jianhao;
//加号
@property (retain, nonatomic) IBOutlet UIButton *jiahao;
//添加代理
@property (nonatomic,assign) id<JJBtnDelegate>DELEGATE;

@property (nonatomic,retain)NSIndexPath * indexpath;

@end



@protocol JJBtnDelegate <NSObject>
//加减的协议方法
- (void)JJBtnClick:(int)tag andcell:(MyOrderTableViewCell * )cell;
//输入框的协议方法
- (void)CellTextFieldSR:(int)tag andcell:(MyOrderTableViewCell * )cell andindexpath:(NSIndexPath *)indexpath;
@end