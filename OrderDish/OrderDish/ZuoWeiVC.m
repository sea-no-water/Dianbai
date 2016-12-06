//
//  ZuoWeiVC.m
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "ZuoWeiVC.h"
#import "SongDanVC.h"
@interface ZuoWeiVC ()

@end

@implementation ZuoWeiVC



- (void)viewDidLoad
{
    [super viewDidLoad];

    _zwlable.layer.borderColor = [[UIColor whiteColor]CGColor];
    _zwlable.layer.borderWidth = 1;
    _zwlable.text = @"请选择座位";

}




//文华轩
- (IBAction)wenhuaxuan:(id)sender
{
    _ZWName = @"文华轩";
    _zwlable.text = _ZWName;

}
//万丽
- (IBAction)wanli:(id)sender
{
    _ZWName = @"万丽";
    _zwlable.text = _ZWName;
}
//博悦庄
- (IBAction)boyuezhuang:(id)sender
{
    _ZWName = @"博悦庄";
    _zwlable.text = _ZWName;

}
//万豪庄
- (IBAction)wanhaozhuang:(id)sender
{
    _ZWName = @"万豪庄";
    _zwlable.text = _ZWName;

}
//艾美
- (IBAction)aimei:(id)sender
{
    _ZWName = @"艾美";
    _zwlable.text = _ZWName;

}
//瑞吉
- (IBAction)ruiji:(id)sender
{
    _ZWName = @"瑞吉";
    _zwlable.text = _ZWName;

}
//嘉里
- (IBAction)jiali:(id)sender
{
    _ZWName = @"嘉里";
    _zwlable.text = _ZWName;

}
//铂尔曼
- (IBAction)boerman:(id)sender
{
    _ZWName = @"铂尔曼";
    _zwlable.text = _ZWName;

}
//丽兹
- (IBAction)lizhi:(id)sender
{
    _ZWName = @"丽兹";
    _zwlable.text = _ZWName;

}
//悦客庄
- (IBAction)yuekezhuang:(id)sender
{
    _ZWName = @"悦客庄";
    _zwlable.text = _ZWName;

}
//四季轩
- (IBAction)sijixuan:(id)sender
{
    _ZWName = @"四季轩";
    _zwlable.text = _ZWName;

}
//露天餐厅
- (IBAction)lutiancanting:(id)sender
{
    _ZWName = @"露天餐厅";
    _zwlable.text = _ZWName;

}
//朗庭
- (IBAction)langting:(id)sender
{
    _ZWName = @"朗庭";
    _zwlable.text = _ZWName;

}
//威斯汀
- (IBAction)weishiting:(id)sender
{
    _ZWName = @"威斯汀";
    _zwlable.text = _ZWName;

}
//希尔顿
- (IBAction)xierdun:(id)sender
{
    _ZWName = @"希尔顿";
    _zwlable.text = _ZWName;

}


//选定按钮
- (IBAction)xuanding:(id)sender
{
    SongDanVC * vc = (SongDanVC * )self.presentingViewController;
    vc.zwName = _ZWName;

    [self dismissViewControllerAnimated:YES completion:nil];
}
//退出
- (IBAction)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dealloc
{
    
    [_ZWName release];
    [_zwlable release];
    [super dealloc];
}

















@end
