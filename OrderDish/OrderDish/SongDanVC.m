//
//  SongDanVC.m
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "SongDanVC.h"
#import "MyOrderViewController.h"
#import "ZuoWeiVC.h"
#import "recordTableDatebase.h"
#import "room_recordTable.h"
#import "room_recordTableDatebase.h"
#import "MyOrderDatabase.h"
#import "orderViewController.h"
#import "LanguageViewController.h"
typedef struct  dateAndTime{
    NSString * date, *time;
}dateAndTime;

dateAndTime dateAndTimeMake(NSString * date,NSString * time){
    
    dateAndTime  dateandtime = {date,time};
    return dateandtime;
    
}

@interface SongDanVC ()

@end

@implementation SongDanVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    _zwLable.text = @"请选择座位";


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //如果值为空，显示请选择座位
    if (_zwName == nil)
    {
        return;
    }
    _zwLable.text = _zwName;

}
//退出
- (IBAction)exit:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//座位界面
- (IBAction)zuowei:(id)sender
{
    ZuoWeiVC * vc = [[ZuoWeiVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
}

//送单按钮
- (IBAction)songdanBtn:(id)sender
{
    if ([_zwLable.text isEqualToString:@"请选择座位"])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择座位" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        alert.tag = 10;
        [alert show];
        [alert release];
        return;
    }
    
    MyOrderViewController * vc = (MyOrderViewController * )self.presentingViewController;
    vc.allOrder = nil;
    int count = 0;
    
    //获取count的值
    [recordTableDatebase selectRecorderTableData:&count];
    count +=1;
    //把数据添加到record
    [recordTableDatebase insertRecordTableWithOrderTable:count];

    //获取日期和时间
   dateAndTime date = [self getDataTimeRoom];
    
    room_recordTable * room = [[room_recordTable alloc]init];
    room.ID = count;
    room.data = date.date;
    room.time = date.time;
    room.room = _zwLable.text;
    //向room_record数据库中添加数据
    [room_recordTableDatebase insertIntoRoomData:room];
    [room release];
    [self dismissViewControllerAnimated:YES completion:nil];

    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"送单成功!" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
//alertview协议方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}



- (dateAndTime )getDataTimeRoom
{
    //获取标准时间
    NSDate * bigdate = [NSDate date];

    //获取当前日期
    NSTimeZone * timezone = [NSTimeZone localTimeZone];
    NSInteger cha = [timezone secondsFromGMTForDate:bigdate];
    //获取当前时区与标准时间差
    NSDate * currentDate = [NSDate dateWithTimeIntervalSinceNow:cha];
    //设置时间显示样式
    NSDateFormatter * formatter = [[[NSDateFormatter alloc]init]autorelease];
    [formatter setDateFormat:@"YYYY年:MM月:DD日 "];
    NSString * date = [formatter stringFromDate:currentDate];
    [formatter setDateFormat:@"HH时:mm分:ss秒"];
    NSString * time = [formatter stringFromDate:currentDate];
    
    
    dateAndTime  dateandtime = dateAndTimeMake(date , time);
    return dateandtime;
    
}



- (void)dealloc {
    [_zwName release];
    [_zwLable release];
    [super dealloc];
}
@end
