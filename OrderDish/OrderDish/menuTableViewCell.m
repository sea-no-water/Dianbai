//
//  menuTableViewCell.m
//  OrderDish
//
//  Created by mac on 16/7/18.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "menuTableViewCell.h"

@implementation menuTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

- (void)dealloc {
    [_menuCellfontLb release];
    [_menuCellLbbelow release];
    [super dealloc];
}
@end
