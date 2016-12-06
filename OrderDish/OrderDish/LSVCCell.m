//
//  LSVCCell.m
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "LSVCCell.h"

@implementation LSVCCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];



}

//按钮的方法
- (IBAction)btnClick:(UIButton *)sender
{
    if ([_Btndelegate respondsToSelector:@selector(buttonClick:andtag:)])
    {
        [_Btndelegate buttonClick:self andtag:sender.tag];
    }
}


- (void)dealloc {
    [_date release];
    [_time release];
    [_room release];
    [_chaxun release];
    [_shanchu release];
    [_count release];
    [super dealloc];
}
@end
