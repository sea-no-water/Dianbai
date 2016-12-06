//
//  recordTableDatebase.h
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
@class room_recordTable;
@interface recordTableDatebase : NSObject
//把order的数据添加到recordTable中
+ (void)insertRecordTableWithOrderTable:(int)groupID;
//取得数据
+ (NSMutableArray * )selectRecorderTableData:(int *)groupID;
//删除所有数据
+ (void)deleteAllData;
//根据groupID删除指定数据
+ (void)deleteDataWithGroupID:(room_recordTable * )room;
//所有数据
+ (NSMutableArray * )selectRecorderTableData;
@end
