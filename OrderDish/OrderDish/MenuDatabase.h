//
//  MenuDatabase.h
//  OrderDish
//
//  Created by mac on 16/7/18.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Group;
@interface MenuDatabase : NSObject
//获取GroupDatabase
+ (NSString * )selectGroupTableDatabase:(NSString * )kind;
//获取MenuTableDatabase
+ (NSMutableArray * )selectMenutableDatabase:(int)groupID;
//获取grouptable的所有数据
+ (NSMutableArray *)getAllGroups;
//获取menu的数据
+ (NSMutableArray *)getMenusWithGroup:(Group *)gp;
@end
