//
//  XiangQingVC.m
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "XiangQingVC.h"
#import "Group.h"
@interface XiangQingVC ()
@property (retain, nonatomic) IBOutlet UIImageView *XSImage;
@property (retain, nonatomic) IBOutlet UILabel *lable;

@end

@implementation XiangQingVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.XSImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",_group.name]];
    self.lable.textColor = [UIColor whiteColor];
    self.lable.text = _group.name;

}

- (IBAction)exit:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dealloc {
    [_XSImage release];
    [_lable release];
    [super dealloc];
}
@end
