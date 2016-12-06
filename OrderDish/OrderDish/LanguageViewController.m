//
//  LanguageViewController.m
//  OrderDish
//
//  Created by mac on 16/7/16.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "LanguageViewController.h"
#import "ViewController.h"
#import "orderViewController.h"
#import "LiShiVC.h"
@interface LanguageViewController ()

@end

@implementation LanguageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


//中文
- (IBAction)ChineseLanguage:(id)sender
{
    orderViewController * vc = [[orderViewController alloc]init];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view.window cache:YES];
    [self.navigationController pushViewController:vc animated:NO];
    [UIView commitAnimations];
    [vc release];
  
}

//英文
- (IBAction)EnglishLanguage:(id)sender
{
    
}

//返回
- (IBAction)BackBtn:(id)sender
{
    
    ViewController * vc = [[ViewController alloc]init];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view.window cache:YES];
    [UIView setAnimationDuration:1];
    
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [UIView commitAnimations];

    [vc release];
}

//历史菜单
- (IBAction)historyBtn:(id)sender
{
    LiShiVC * vc = [[LiShiVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
    
}


@end
