//
//  DatabaseManager.h
//  01-SQLiteDemo
//
//  Created by qinglinfu on 16/1/30.
//  Copyright © 2016年 十安科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject


+ (id)shareDatabaseManager;



/**
 *  创建或打开数据库
 *
 *  @param dbName 数据库名称
 */
- (BOOL)createOrOpenDatabase:(NSString *)dbName;


/**
 *  关闭数据库
 */
- (void)closeDatabase;


/**
 *  创建表
 */
- (void)createTable:(NSString *)sql;


/**
 *  插入数据
 */
- (void)insertDatas:(NSString *)sql;


/**
 *  添加字段
 */
- (void)addColumn:(NSString *)sql;


/**
 *  更新数据
 */
- (void)updateDatas:(NSString *)sql;


/**
 *  删除数据
 */
- (void)deleteDatas:(NSString *)sql;


/**
 *  查询数据
 */
- (NSArray *)selectDatas:(NSString *)sql;

@end
