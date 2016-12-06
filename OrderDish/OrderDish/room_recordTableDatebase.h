//
//  room_recordTableDatebase.h
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
@class room_recordTable;
@interface room_recordTableDatebase : NSObject
//添加数据到历史数据表
+ (void)insertIntoRoomData:(room_recordTable * )room;
//从数据库中取出数据
+ (NSMutableArray * )getRoomData;
//删除所有数据
+ (void)deleteAllData;
//根据id删除指定数据
+ (void)deleteDateWithRoom:(room_recordTable * )room;
@end
