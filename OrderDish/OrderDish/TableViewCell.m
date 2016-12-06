//
//  TableViewCell.m
//  OrderDish
//
//  Created by mac on 16/7/16.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

   

}

- (void)dealloc {
    [_button release];
    [super dealloc];
}
@end
