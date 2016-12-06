//
//  recordTable.h
//  OrderDish
//
//  Created by mac on 16/7/21.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface recordTable : NSObject
@property (nonatomic,assign)int ID;
@property (nonatomic,assign)int stateNum;
@property (nonatomic,copy)NSString * menuName;
@property (nonatomic,copy)NSString * menuPrice;
@property (nonatomic,copy)NSString * menuKind;
@property (nonatomic,assign)int menuNum;
@property (nonatomic,copy)NSString * menuRemark;
@property (nonatomic,assign)int groupID;

@end
