//
//  Group.m
//  OrderDish
//
//  Created by mac on 16/7/19.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "Group.h"

@implementation Group



- (void)dealloc
{
    [_kind release];
    [_image release];
    [_himage release];
    
    [_unit release];
    [_iKind release];
    [_detail release];
    [_picName release];
    [_name release];
    [super dealloc];
}
@end
