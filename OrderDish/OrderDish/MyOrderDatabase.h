//
//  MyOrderDatabase.h
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyDianCai;
@interface MyOrderDatabase : NSObject
//取order的值
+ (NSMutableArray *)getOrderDatebase;
//删除order的值
+ (void)deleteOrderDatabase:(int)ID;
//加减方法
+ (void)JJBtnUpdataData:(MyDianCai * )mc andNum:(int)num;
//更改num输入框内容
+ (void)CellTextFieldNum:(MyDianCai * )mc andNum:(int)num;
//更改remark的数据
+ (void)CellTextFieldRemark:(MyDianCai *)mc andRemark:(NSString * )text;
//删除所有的数据
+ (void)deleteAllOrderdata;

@end
