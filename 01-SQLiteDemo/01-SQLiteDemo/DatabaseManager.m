//
//  DatabaseManager.m
//  01-SQLiteDemo
//
//  Created by qinglinfu on 16/1/30.
//  Copyright © 2016年 十安科技. All rights reserved.
//

#import "DatabaseManager.h"
#import <sqlite3.h>
#import "Person.h"

static DatabaseManager *dbManager = nil;
@implementation DatabaseManager
{
    sqlite3 *_sqlDB;
}

+ (instancetype)shareDatabaseManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dbManager = [[self alloc] init];
    });
    
    return dbManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (dbManager == nil) {
        
        dbManager = [super allocWithZone:zone];
    }
    
    return dbManager;
}


#pragma mark - 创建\打开数据库
- (BOOL)createOrOpenDatabase:(NSString *)dbName
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [docPath stringByAppendingFormat:@"/%@.sqlite",dbName];
    
    // 打开数据库
    int result = sqlite3_open([dataPath UTF8String], &_sqlDB);
    if (result == SQLITE_OK) {
        
        NSLog(@"创建/打开成功！");
        return YES;
    }
    NSLog(@"创建/打开失败！");
    // 关闭数据库
    sqlite3_close(_sqlDB);
    
    return NO;
}

#pragma mark - 关闭数据库
- (void)closeDatabase
{
    sqlite3_close(_sqlDB);
    
}


#pragma mark - 创建数据库表
- (void)createTable:(NSString *)sql;
{
    char *error;
    int result = sqlite3_exec(_sqlDB, [sql UTF8String], NULL, NULL, &error);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"创建表成功！");
        
    } else {
        
        NSLog(@"创建表失败！");
        
        sqlite3_close(_sqlDB);
    }
    
}

#pragma mark - 插入数据
- (void)insertDatas:(NSString *)sql
{
    char *error;
    int result = sqlite3_exec(_sqlDB, [sql UTF8String], NULL, NULL,&error);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"数据插入成功！");
        
    } else {
        
        NSLog(@"数据插入失败！");
    }
}

#pragma mark - 添加字段
- (void)addColumn:(NSString *)sql
{
    char *error;
    int result = sqlite3_exec(_sqlDB, [sql UTF8String], NULL, NULL,&error);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"添加字段成功！");
        
    } else {
        
        NSLog(@"添加字段成功！");
    }
}


#pragma mark - 更新数据
- (void)updateDatas:(NSString *)sql
{
    char *error;
    int result = sqlite3_exec(_sqlDB, [sql UTF8String], NULL, NULL,&error);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"数据更新成功！");
        
    } else {
        
        NSLog(@"数据更新失败！");
    }
}


#pragma mark - 删除数据
- (void)deleteDatas:(NSString *)sql
{
    char *error;
    int result = sqlite3_exec(_sqlDB, [sql UTF8String], NULL, NULL,&error);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"数据删除成功！");
        
    } else {
        
        NSLog(@"数据删除失败！");
    }
}

#pragma mark - 查询数据
- (NSArray *)selectDatas:(NSString *)sql
{
    NSMutableArray *perObjs = [NSMutableArray array];
    sqlite3_stmt *stmt;
    
    // 预处理SQL语句
    int result = sqlite3_prepare_v2(_sqlDB, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
        // 执行SQL语句
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            // 获取对应的字段数据
            char *ID = (char *)sqlite3_column_text(stmt, 0);
            char *name = (char *)sqlite3_column_text(stmt, 1);
            char *sex = (char *)sqlite3_column_text(stmt, 2);
            char *tel = (char *)sqlite3_column_text(stmt, 3);
            int age = sqlite3_column_int(stmt, 4);
            
            // 将数据保存到mode中
            Person *per = [[Person alloc] init];
            per.pID = [NSString stringWithUTF8String:ID];
            per.pName = [NSString stringWithUTF8String:name];
            per.pSex = [NSString stringWithUTF8String:sex];
            per.pTel = [NSString stringWithUTF8String:tel];
            per.pAge = age;
            
            [perObjs addObject:per];
            
        }
    } else {
        
        sqlite3_close(_sqlDB);
        NSLog(@"查询数据失败！");
    }
    // 释放stmt
    sqlite3_finalize(stmt);
    return perObjs;
}


@end
