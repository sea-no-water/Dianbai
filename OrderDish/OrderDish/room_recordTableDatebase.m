//
//  room_recordTableDatebase.m
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "room_recordTableDatebase.h"
#import "room_recordTable.h"
#import "FMDatabase.h"
extern FMDatabase * __db;
@implementation room_recordTableDatebase

//添加数据到历史数据表
+ (void)insertIntoRoomData:(room_recordTable * )room
{
    if ([__db open])
    {
        [__db executeUpdate:[NSString stringWithFormat:@"insert into room_recordTable (id,date,time,room) values (%d,'%@','%@','%@')",room.ID,room.data,room.time,room.room]];
        [__db close];
    }
    
    
}

//从数据库中取出数据
+ (NSMutableArray * )getRoomData
{
    NSMutableArray * array = [NSMutableArray array];
    if ([__db open])
    {
        
        FMResultSet * set = [__db executeQuery:[NSString stringWithFormat:@"select * from room_recordTable"]];
        while ([set next])
        {
            room_recordTable * room = [[room_recordTable alloc]init];
            room.ID = [set intForColumnIndex:0];
            room.data = [set stringForColumnIndex:1];
            room.time = [set stringForColumnIndex:2];
            room.room = [set stringForColumnIndex:3];
            
            [array addObject:room];
            [room release];
            NSLog(@"%@",array);
        }
        return  array;

        [set close];
        [__db close];
        
    }
    NSLog(@"1111");

    return nil;
}

//删除所有数据
+ (void)deleteAllData
{
    
    if ([__db open])
    {
        [__db executeUpdate:@"delete from room_recordTable"];
        [__db close];
    }

}

//根据id删除指定数据
+ (void)deleteDateWithRoom:(room_recordTable * )room
{
    
    if ( [__db open])
    {
        [__db executeUpdate:[NSString stringWithFormat:@"delete from room_recordTable where id = %d",room.ID]];
        [__db close];
    }
    
}



@end
