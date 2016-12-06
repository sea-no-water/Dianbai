//
//  MyOrderTableViewCell.m
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//加减按钮的方法
- (IBAction)JJBtnClick:(UIButton *)sender
{
    if ([_DELEGATE respondsToSelector:@selector(JJBtnClick:andcell:)])
    {
        //返回tag和cell
        [_DELEGATE JJBtnClick:sender.tag andcell:self];

    }
}


//输入框的协议方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_DELEGATE respondsToSelector:@selector(CellTextFieldSR:andcell:andindexpath:)])
    {
        [_DELEGATE CellTextFieldSR:textField.tag andcell:self andindexpath:_indexpath];

    }
}

- (void)dealloc {
    [_name release];
    [_price release];
    [_beizhu release];
    [_num release];
    [_jianhao release];
    [_jiahao release];
    [super dealloc];
}
@end
