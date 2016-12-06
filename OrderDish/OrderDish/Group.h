//
//  Group.h
//  OrderDish
//
//  Created by mac on 16/7/19.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject
//menu
@property (nonatomic,copy)NSString * iKind;
@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSString * unit;
@property (nonatomic,assign)int price;
@property (nonatomic,copy)NSString * detail;
@property (nonatomic,copy)NSString * picName;

//group
@property (nonatomic,copy)NSString * image;
@property (nonatomic,copy)NSString * himage;
@property (nonatomic,assign)int ID;
@property (nonatomic,copy)NSString * kind;
@end
