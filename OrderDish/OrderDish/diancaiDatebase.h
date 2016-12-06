//
//  diancaiDatebase.h
//  OrderDish
//
//  Created by mac on 16/7/20.
//  Copyright (c) 2016年 刘文海. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Group;
@interface diancaiDatebase : NSObject
+ (void)insertOrderWithGroup:(Group * )gp;

@end
