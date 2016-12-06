//
//  ViewController.m
//  OrderDish
//
//  Created by mac on 16/7/16.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "ViewController.h"
#import "LanguageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //获取沙盒的位置
    NSLog(@"\n%@",NSHomeDirectory());
    
    //把工程中的文件导入到沙盒中
    [self copydatabase];

    


}

#pragma mark 导入文件到沙盒
//拷贝数据库到沙盒
- (void)copydatabase
{
    //获取文件原来位置
    NSString * soucefile = [[NSBundle mainBundle]pathForResource:@"database" ofType:@"sqlite"];
    //选择目的位置
    NSString * filepath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
    BOOL isexist = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
    if (isexist == YES)
    {
        NSLog(@"文件已存在");
        return;
    }
    NSError * error = nil;
    BOOL isSeccess = [[NSFileManager defaultManager] copyItemAtPath:soucefile toPath:filepath error:&error];
    if (isSeccess == NO)
    {
        NSLog( @"拷贝失败");
    }
    else
    {
        NSLog(@"拷贝成功");
    }
    
}


- (IBAction)diancaiXTBtn:(id)sender
{
    
    LanguageViewController * vc = [[LanguageViewController alloc]init];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view.window cache:YES];
    [UIView setAnimationDuration:1];
    
    [self.navigationController pushViewController:vc animated:NO];
    [UIView commitAnimations];

    [vc release];
}
//首页
- (IBAction)shouye:(id)sender
{
    //打开网站首页
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"]];

}

@end
