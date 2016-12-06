//
//  MenuDatabase.m
//  OrderDish
//
//  Created by mac on 16/7/18.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "MenuDatabase.h"
#import "FMDatabase.h"
#import "FMDatabase.h"
#import <sqlite3.h>
#import "FMResultSet.h"
#import "Group.h"
extern FMDatabase * __db;
@implementation MenuDatabase


//获取grouptable数据
+ (NSString * )selectGroupTableDatabase:(NSString * )kind
{
    NSString * name = nil;
    if ([__db open])
    {
        [__db setShouldCacheStatements:YES];
        FMResultSet * set = [__db executeQuery:[NSString stringWithFormat:@"select * from groupTable where kind = '%@'",kind]];
        while ([set next])
        {
            name = [set stringForColumn:@"name"];
            
        }
        [set close];
        return name;

    }
    [__db close];
    return nil;
}

//获取所有的Groups数据
+ (NSMutableArray *)getAllGroups
{
    NSMutableArray * array = [NSMutableArray array];
    if ([__db open])
    {
        FMResultSet * set = [__db executeQuery:@"select * from groupTable"];
        while ([set next])
        {
            Group * gp = [[Group alloc]init];
            gp.ID = [set intForColumnIndex:0];
            gp.kind = [set stringForColumnIndex:1];
            gp.name = [set stringForColumnIndex:2];
            gp.image = [set stringForColumnIndex:3];
            gp.himage = [set stringForColumnIndex:4];
            
            [array addObject:gp];
            [gp release];
        }
        [set close];
        [__db close];
        
        return array;
    }
    
    return nil;
   
}


//获取menutable数据
+ (NSMutableArray * )selectMenutableDatabase:(int)groupID
{
    NSMutableArray * array = [NSMutableArray array];

    
    if ([__db open])
    {
        FMResultSet * set = [__db executeQuery:[NSString stringWithFormat:@"select * from menuTable where groupID = %d",groupID]];
        while ([set next])
        {
            Group * group = [[Group alloc]init];
            
            group.iKind = [set stringForColumn:@"iKind"];
            group.name = [set stringForColumn:@"name"];
            group.price = [set intForColumn:@"price"];
            group .unit = [set stringForColumn:@"unit"];
            group.detail = [set stringForColumn:@"detail"];
            group.picName = [set stringForColumn:@"picName"];
          
            [array addObject:group];
          
            [group release];
        }
        

        [set close];
        [__db close];
        
    }
    
    return array;
    
}

//获取menu的数据
+ (NSMutableArray *)getMenusWithGroup:(Group *)gp
{
    if (![__db open]) {
        return nil;
    }
    //分割Group表中的数据。
    NSArray *array = [gp.name componentsSeparatedByString:@"|"];
    //获取每一个名字
    //用来存储种菜的数组
    NSMutableArray *array1 = [NSMutableArray array];
    for (NSString *name in array) {
        //存储每次按照kind取出的数据
        NSMutableArray *array2 = [NSMutableArray array];
        FMResultSet *set = [__db executeQuery:@"select * from menuTable where iKind = ?",name];
        while ([set next]) {
            Group *mm = [[Group alloc] init];
            mm.ID = [set intForColumnIndex:1];
            mm.kind = [set stringForColumnIndex:2];
            mm.name = [set stringForColumnIndex:3];
            mm.price = [set intForColumnIndex:4];
            mm.unit = [set stringForColumnIndex:5];
            mm.detail = [set stringForColumnIndex:6];
            mm.picName = [set stringForColumnIndex:7];
            
            [array2 addObject:mm];
            
            [mm release];
        }
        [array1 addObject:array2];
    }
    return array1;
    
}

@end
