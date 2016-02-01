//
//  Person.h
//  01-SQLiteDemo
//
//  Created by qinglinfu on 16/1/30.
//  Copyright © 2016年 十安科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic, copy)NSString *pID;
@property(nonatomic, copy)NSString *pName;
@property(nonatomic, copy)NSString *pSex;
@property(nonatomic, copy)NSString *pTel;
@property(nonatomic, assign)NSInteger pAge;

@end
