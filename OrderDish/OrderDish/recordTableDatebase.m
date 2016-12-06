//
//  recordTableDatebase.m
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "recordTableDatebase.h"
#import "FMDatabase.h"
#import "MyOrderDatabase.h"
#import "recordTable.h"
#import "MyDianCai.h"
#import "room_recordTable.h"
extern FMDatabase * __db;

@implementation recordTableDatebase
//把order的数据添加到recordTable中
+ (void)insertRecordTableWithOrderTable:(int)groupID
{
    
    NSMutableArray *array = [MyOrderDatabase getOrderDatebase];
    for (MyDianCai * mc in array)
    {
        recordTable * record = [[recordTable alloc]init];
        record.ID = mc.ID;
        record.menuName = mc.name;
        record.menuPrice = mc.price;
        record.menuKind = mc.kind;
        record.menuNum = mc.Num;
        record.menuRemark = mc.remark;
        record.stateNum = 1;
        if ([__db open])
        {
            
            [__db executeUpdate:[NSString stringWithFormat:@"insert into recordTable (stateNum,menuName,menuPrice,menuKind,menuNum,menuRemark,groupID) values (%d,'%@','%@','%@',%d,'%@',%d)",record.stateNum,record.menuName,record.menuPrice,record.menuKind,record.menuNum,record.menuRemark,groupID]];
            
            //添加后把order的数据删除
            [MyOrderDatabase deleteAllOrderdata];
            
            [__db close];
        }
        [record release];
    }
    
    
}

//取得数据
+ (NSMutableArray * )selectRecorderTableData:(int *)groupID
{
    
    if ([__db open])
    {
        NSMutableArray * array = [NSMutableArray array];
        FMResultSet * set = [__db executeQuery:[NSString stringWithFormat:@"select * from recordTable "]];
        while ([set next])
        {
            recordTable * record = [[recordTable alloc]init];
            record.ID = [set intForColumnIndex:0];
            record.stateNum = [set intForColumnIndex:1];
            record.menuName = [set stringForColumnIndex:2];
            record.menuPrice = [set stringForColumnIndex:3];
            record.menuKind = [set stringForColumnIndex:4];
            record.menuNum = [set intForColumnIndex:5];
            record.menuRemark = [set stringForColumnIndex:6];
            record.groupID = [set intForColumnIndex:7];
            *groupID = [set intForColumnIndex:7];
            [array addObject:record];
            [record release];
        }
        [set close];
        [__db close];
        return array;
    }
    return nil;
    
}

//所有数据
+ (NSMutableArray * )selectRecorderTableData
{
    
    if ([__db open])
    {
        NSMutableArray * array = [NSMutableArray array];
        FMResultSet * set = [__db executeQuery:[NSString stringWithFormat:@"select * from recordTable "]];
        while ([set next])
        {
            recordTable * record = [[recordTable alloc]init];
            record.ID = [set intForColumnIndex:0];
            record.stateNum = [set intForColumnIndex:1];
            record.menuName = [set stringForColumnIndex:2];
            record.menuPrice = [set stringForColumnIndex:3];
            record.menuKind = [set stringForColumnIndex:4];
            record.menuNum = [set intForColumnIndex:5];
            record.menuRemark = [set stringForColumnIndex:6];
            record.groupID = [set intForColumnIndex:7];
            [array addObject:record];
            [record release];
        }
        [set close];
        [__db close];
        return array;
    }
    return nil;
    
}

//删除所有数据
+ (void)deleteAllData
{
    if ([__db open])
    {
        [__db executeUpdate:@"delete from recordTable"];
        [__db close];
    }
}

//根据groupID删除指定数据
+ (void)deleteDataWithGroupID:(room_recordTable * )room
{
    
    if ([__db open])
    {
        [__db executeUpdate:[NSString stringWithFormat:@"delete from recordTable where groupID = %d",room.ID]];
        [__db close];
    }
    
}
@end
