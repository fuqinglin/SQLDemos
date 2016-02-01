//
//  Person.m
//  01-SQLiteDemo
//
//  Created by qinglinfu on 16/1/30.
//  Copyright © 2016年 十安科技. All rights reserved.
//

#import "Person.h"

@implementation Person

- (NSString *)description
{
    return [NSString stringWithFormat:@"id:%@,name:%@,sex:%@,tel:%@,age:%ld",_pID,_pName,_pSex,_pTel,_pAge];
}

@end
