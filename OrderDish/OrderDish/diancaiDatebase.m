//
//  diancaiDatebase.m
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import "diancaiDatebase.h"
#import "Group.h"
#import "FMDatabase.h"
extern FMDatabase * __db;
@implementation diancaiDatebase

//添加点菜
+ (void)insertOrderWithGroup:(Group * )gp
{
    if ([__db open])
    {
        int count = 0;
        BOOL isCZ = [self panduan:gp count:&count];
        count += 1;
 
        NSString * sql = nil;
        if (isCZ == YES)
        {
            sql = [NSString stringWithFormat:@"update orderTable set menuNum = %d where menuName = '%@'",count,gp.name];
            
        }
        else
        {
            sql = [NSString stringWithFormat:@"insert into orderTable (menuName,price,kind,menuNum) values('%@','%d','%@','%d')",gp.name,gp.price,gp.iKind,count];
        }
        
        [__db executeUpdate:sql];
        [__db close];

    }

}


//判断是否存在菜
+ (BOOL)panduan:(Group *)gp count:(int *)Num
{
    
    FMResultSet * set = [__db executeQuery:[NSString stringWithFormat:@"select * from orderTable where menuName = '%@'",gp.name]];
    if ([set next])
    {
        *Num = [set intForColumnIndex:4];
        [set close];
        return YES;
    }
    
    
    return NO;
    
}



@end
