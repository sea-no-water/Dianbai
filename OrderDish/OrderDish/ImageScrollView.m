//
//  ImageScrollView.m
//  OrderDish
//
//  Created by mac on 16/7/19.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "ImageScrollView.h"
#import "Group.h"
@implementation ImageScrollView


- (void)showImageWithArray:(NSArray * )array
{
    for (UIView * subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
    
    self.contentOffset = CGPointMake(0, 0);
    for (int  i = 0; i < array.count; i ++)
    {
        Group * group = array[i];
        
        
        UIImageView * image = [[UIImageView alloc]init];
        image.frame = CGRectMake(self.bounds.size.width*i, 12, self.bounds.size.width, self.bounds.size.height);
        image.image = [UIImage imageNamed:group.picName];
        [self addSubview: image];
        [image release];
        
    }
    
    self.contentSize = CGSizeMake(self.bounds.size.width*array.count , 0);
    
}


@end
