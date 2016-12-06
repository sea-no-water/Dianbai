//
//  MyOrderDatabase.m
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "MyOrderDatabase.h"
#import "MyDianCai.h"
#import "FMDatabase.h"

extern FMDatabase * __db;
@implementation MyOrderDatabase

//获取order的值
+ (NSMutableArray *)getOrderDatebase
{
    if ([__db open])
    {
        NSMutableArray * array = [NSMutableArray array];
        FMResultSet * set = [__db executeQuery:@"select * from orderTable"];
        while ([set next])
        {
            MyDianCai * mc = [[MyDianCai alloc]init];
            mc.ID = [set intForColumnIndex:0];
            mc.name = [set stringForColumnIndex:1];
            mc.price = [set stringForColumnIndex:2];
            mc.kind = [set stringForColumnIndex:3];
            mc.Num = [set intForColumnIndex:4];
            mc.remark = [set stringForColumnIndex:5];
            [array addObject:mc];
            [mc release];
        }
        [set close];
        [__db close];
        return array;
    }
    
    return nil;
}
//删除数据
+ (void)deleteOrderDatabase:(int)ID
{
    if ( [__db open])
    {
        [__db executeUpdate:[NSString stringWithFormat:@"delete from orderTable where id = %d",ID]];
        [__db close];
    }
    
    
}

//加减按钮方法
+ (void)JJBtnUpdataData:(MyDianCai * )mc andNum:(int)num
{
    if ( [__db open])
    {
        [__db executeUpdate:[NSString  stringWithFormat:@"update orderTable set menuNum = %d where id = %d",num,mc.ID]];
        [__db close];
    }
 
}

//更改num输入框内容
+ (void)CellTextFieldNum:(MyDianCai * )mc andNum:(int)num
{
    if ([__db open])
    {
        [__db executeUpdate:[NSString stringWithFormat:@"update orderTable set menuNum = %d where id = %d ",num,mc.ID]];
        [__db close];
    }
  
}

//更改remark的数据
+ (void)CellTextFieldRemark:(MyDianCai *)mc andRemark:(NSString * )text
{
    if ([__db open])
    {
        [__db executeUpdate:[NSString stringWithFormat:@"update orderTable set remark = '%@' where id = %d",text,mc.ID]];
        [__db close];
    }
    
}

//删除所有的数据
+ (void)deleteAllOrderdata
{
    if ([__db open])
    {
        [__db executeUpdate:@"delete from orderTable where id"];
        [__db close];
    }
}

@end
