//
//  ViewController.m
//  01-SQLiteDemo
//
//  Created by qinglinfu on 16/1/30.
//  Copyright © 2016年 十安科技. All rights reserved.
//

#import "ViewController.h"
#import "DatabaseManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",NSHomeDirectory());
    
    // 1、创建、打开
    [[DatabaseManager shareDatabaseManager] createOrOpenDatabase:@"testDB"];
    
    // 2、创建表
    NSString *sql = @"CREATE TABLE IF NOT EXISTS Person(pID TEXT PRIMAY KEY,pName TEXT,pSex TEXT, pTel TEXT)";
    [[DatabaseManager shareDatabaseManager] createTable:sql];
    
    // 3、添加数据
    NSString *pID = @"1002";
    NSString *pName = @"kitty";
    NSString *pSex = @"女";
    NSString *pTel = @"98777331";
    NSString *sql_insert = [NSString stringWithFormat:@"INSERT INTO Person (pID,pName,pSex,pTel) VALUES ('%@','%@','%@','%@')",pID,pName,pSex,pTel];
    
    [[DatabaseManager shareDatabaseManager] insertDatas:sql_insert];
    
    // 4、添加字段
    NSString *culumn = @"pAge INTEGER";
    NSString *sql_addCulumn = [NSString stringWithFormat:@"ALTER TABLE Person ADD COLUMN %@ ",culumn];
    [[DatabaseManager shareDatabaseManager] addColumn:sql_addCulumn];
    
    // 5、更新数据
//    NSString *sql_update = [NSString stringWithFormat:@"UPDATE Person SET pAge = %d WHERE pName = 'kitty'",20];
    NSString *sql_update = [NSString stringWithFormat:@"UPDATE Person SET pAge = %d WHERE pName = '王伟'",35];
    [[DatabaseManager shareDatabaseManager] updateDatas:sql_update];
    
    //6、删除数据
    NSString *sql_Delete = [NSString stringWithFormat:@"DELETE FROM Person WHERE pName = '%@'",@"kitty"];
    [[DatabaseManager shareDatabaseManager] deleteDatas:sql_Delete];
    
    //7、查询数据
    NSString *sql_Select = [NSString stringWithFormat:@"SELECT * FROM Person WHERE pAge > %d",20];
    NSArray *objs = [[DatabaseManager shareDatabaseManager] selectDatas:sql_Select];
    NSLog(@"%@",objs);
}



@end
