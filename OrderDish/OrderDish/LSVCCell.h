//
//  LSVCCell.h
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol btnDelegate ;


@interface LSVCCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *count;
@property (retain, nonatomic) IBOutlet UILabel *date;
@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *room;
@property (retain, nonatomic) IBOutlet UIButton *shanchu;

@property (retain, nonatomic) IBOutlet UIButton *chaxun;

//添加代理
@property (nonatomic,assign)id<btnDelegate>Btndelegate;
@end

@protocol btnDelegate <NSObject>

- (void)buttonClick:(LSVCCell * )cell andtag:(int)tag;

@end